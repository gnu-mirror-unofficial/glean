;;; guilecraft --- Fast learning tool.         -*- coding: utf-8 -*-


;; Central instance to reference all known record-type-descriptors in
;; use.  I want to avoid using some manual form of RTD registration,
;; so I refer to existing data-managers where possible:  
;; - problem-type manager indexes problem-types by rtd; adding the rt
;;   constructor would make it a suitable store of problem-type rtds.
;; - gmodules are a special case accounted for non-dynamically
;; - gprofiles are special too
;; - gsets?
;; - scorecards?
;; - credits?
;; - materials?
;; - requests?
;; - 

(define-module (guilecraft known-rtd-manager)
  #:export (known-rtds
	    known-rtd?
	    register-rtds))

(define (register-rtds records)
  "Register each record in RECORDS in known-rtd-manager, to ensure
that communications through the socket can decompose and recompose
record-types."
  (define (reg remaining)
    (if (null? remaining)
	#t
	(let ((rtd (record-type-descriptor (car remaining))))
	  (known-rtds 'put (record-type-name rtd) rtd)
	  (reg (cdr remaining)))))
  (reg records))

(define (known-rtd? rec-id)
  "Syntactic sugar. Return false if rec-id is not yet known by known-rtds."
  (known-rtds 'get rec-id))

(define known-rtds
  (let ((cache '()))
    (lambda (msg . args)
      (define (loop k l)
	(cond ((null? l)
	       #f)
	      ((eqv? k (car (car l)))
	       (cdr (car l)))
	      (else (loop k (cdr l)))))

      (cond ((and (eqv? msg 'put)
		  (not (known-rtd? (car args))))
	     (begin
	       (set! cache (cons (cons (car args)
 (cadr args))
				  cache))
	       #t))
	    ((eqv? msg 'put)
	     #f)
	    ((eqv? msg 'get)
	     (loop (car args) cache))
	    ((eqv? msg 'check)
	     cache)))))
