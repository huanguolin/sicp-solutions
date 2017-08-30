#lang scheme
; 预定义函数
(define (make-interval a b) (cons a b))
; 题目要求的函数
(define (lower-bound z)
  (min (car z)
       (cdr z)))
(define (upper-bound z)
  (max (car z)
       (cdr z)))
;test
(define z (make-interval 3.5 2.3))
(lower-bound z)
(upper-bound z)