#lang scheme
; 工具函数
(define (square x) (* x x))
(define (average a b c) (/ (+ a b c) 3))
; from 1.42
(define (compose f1 f2) 
  (lambda (x) (f1 (f2 x))))
; from 1.43
(define (repeated f n)
  (cond ((= n 0) (lambda (x) (f x)))
        ((even? n) (repeated (compose f f) 
                             (- n 2)))
        (else (compose f 
                       (repeated f 
                                 (- n 1))))))
; 题目要求的函数
(define dx 0.00001)
(define (smooth f)
  (lambda (x) (average (f (- x dx))
                       (f x)
                       (f (+ x dx)))))
(define (n-fold-smoothed f n)
  ((repeated smooth n) f))
; test
((smooth square) 2)
((n-fold-smoothed square 1) 2)