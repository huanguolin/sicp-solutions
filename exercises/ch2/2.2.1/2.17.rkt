#lang scheme
(define (last-pair list)
  (cond ((null? list) null)
        ((null? (cdr list)) (car list))
        (else (last-pair (cdr list)))))
; test
(last-pair (list 1 2 3 4))
(last-pair (list 1))
(last-pair null)