#lang scheme
; 预定义函数
(define (make-interval a b) (cons a b))
(define (lower-bound z)
  (min (car z)
       (cdr z)))
(define (upper-bound z)
  (max (car z)
       (cdr z)))

; 题目要求的函数
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))
; test
(define x (make-interval 2 9))
(define y (make-interval 3 5))
(sub-interval x y)