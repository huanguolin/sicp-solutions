#lang scheme

; not change from 2.59
(define (element-of-set? x set)
  (cond ((null? set) false)
	((equal? x (car set)) true)
	(else (element-of-set? x (cdr set)))))


; re-defined addjoin-set
(define (addjoin-set x set) 
  (cons x set))
; test
(addjoin-set 2 (list 1 2 3))

; re-defined union-set
(define (union-set set1 set2) 
  (append set1 set2))
; test
(union-set (list 1 2 3) (list 2 3 4))

; re-defined intersection-set
(define (remove-element-of-set x set)
  (define (iter product rest)
    (cond ((null? rest) product)
	  ((equal? x (car rest)) (iter product 
				       (cdr rest)))
	  (else (iter (append product 
			      (list (car rest))) 
		      (cdr rest)))))
  (iter null set))
; test 
(remove-element-of-set 5 (list 1 2 5 6 7 8 5))
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
	((element-of-set? (car set1) set2)
	 (cons (car set1) 
	       (intersection-set (cdr set1) 
				 (remove-element-of-set (car set1) 
							set2))))
	(else (intersection-set (cdr set1) set2))))
; test
(intersection-set (list 1 2 2 3) (list 2 2 3 4))

