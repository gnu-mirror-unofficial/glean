;;; guilecraft --- fast learning tool.         -*- coding: utf-8 -*-

;; Copyright (C) 2008, 2010, 2012 Alex Sassmannshausen

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, contact:
;;
;; Free Software Foundation           Voice:  +1-617-542-5942
;; 59 Temple Place - Suite 330        Fax:    +1-617-542-2652
;; Boston, MA  02111-1307,  USA       gnu@gnu.org

(define-module (tests scorecards)
  #:use-module (srfi srfi-64)
  #:use-module (tests test-utils)
  #:use-module (quickcheck quickcheck)
  #:use-module (tests quickcheck-defs)

  #:use-module (guilecraft data-types scorecards))

(test-begin "scorecard-tests")

(test-assert "basic blob creation"
  (quickcheck (lambda (_) (blob? _))
              $blob))

(test-assert "basic scorecard creation"
  (quickcheck (lambda (_) (scorecard? _))
              $scorecard))

(test-end "scorecard-tests")
