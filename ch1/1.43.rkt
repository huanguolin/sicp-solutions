#lang scheme
(define (compose f1 f2) 
  (lambda (x) (f1 (f2 x))))

(define (repeated f n)
  (cond ((= n 0) (lambda (x) (f x)))
        ((even? n) (repeated (compose f f) 
                             (- n 2)))
        (else (compose f 
                       (repeated f 
                                 (- n 1))))))
; test 
(define (square x) (* x x))
((repeated square 2) 5) ; 625