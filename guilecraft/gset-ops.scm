;;; guilecraft --- Fast learning tool.         -*- coding: utf-8 -*-

(define-module (guilecraft gset-ops)
  #:use-module (guilecraft data-types gmodules)
  #:use-module (guilecraft data-types gsets)
  #:export (get-tag-problems))

(define get-tag-problems
  (lambda (gset-tag gmodule)
    "Return the challenge/solution pairs subsumed under TAG in a given GMODULE.

get-tag-problems searches gmodule parts and returns '() or the problems subsumed within a tag within a module."
    (define helper
      (lambda (gset-tag gmodule-gsets)
	(cond ((null? gmodule-gsets)
	       '())
	      ((eq? gset-tag (get-tag (car gmodule-gsets)))
	       (get-problems (car gmodule-gsets)))
	      (else (helper gset-tag (cdr gmodule-gsets))))))
    (helper gset-tag (gmodule-parts gmodule))))
