#lang scheme


; -----------------------
; required
; -----------------------
; 复杂度 O(n^2)
; 因为 append 是O(n)
(define (adjoin-set x set)
  (define (iter product rest)
    (cond ((null? rest) (append product (list x)))
	  ((= x (car rest)) set)
	  ((< x (car rest)) (append product (cons x rest)))
	  (else (iter (append product (list (car rest))) (cdr rest)))))
  (iter null set))
; test
(adjoin-set 5 (list 1 3 4 5))
(adjoin-set 5 (list 1 3 4))
(adjoin-set 5 (list 1 3 4 6 7))
