#lang scheme

; O(n)
(define (union-set set1 set2)
  (cond ((null? set1) set2) 
	((null? set2) set1)
	(else (let ((e1 (car set1))
	      (e2 (car set2))
	      (rest1 (cdr set1))
	      (rest2 (cdr set2)))
	  (cond ((= e1 e2) (cons e1 (union-set rest1 rest2)))
		((< e1 e2) (cons e1 (union-set rest1 set2)))
		(else (cons e2 (union-set set1 rest2))))))))
; test
(union-set (list 1 2 3) (list 3 4 5))

