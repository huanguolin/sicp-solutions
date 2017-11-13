#lang scheme

(provide make-leaf-set)

(require "leaf.rkt"
	 "tree.rkt")

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
       (adjoin-set (make-leaf (car pair) ; symbol
			      (cadr pair)) ; frequency
		   (make-leaf-set (cdr pairs))))))
(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((< (weight x) (weight (car set))) (cons x set))
	(else (cons (car set)
		    (adjoin-set x (cdr set))))))
