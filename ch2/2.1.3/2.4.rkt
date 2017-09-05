#lang scheme
; 题中预定义函数
(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))
; 验证
(car (cons 1 2))

; 补上 cdr
(define (cdr z)
  (z (lambda (p q) q)))
; 验证
(cdr (cons 1 2))