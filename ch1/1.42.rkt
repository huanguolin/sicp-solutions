#lang scheme
(define (compose f1 f2) 
  (lambda (x) (f1 (f2 x))))
; test 
(define (square x) (* x x))
(define (inc x) (+ x 1))
((compose square inc) 6)