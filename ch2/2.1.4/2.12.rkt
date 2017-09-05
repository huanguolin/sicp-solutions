#lang scheme
; 预定义函数
(define (make-interval a b) (cons a b))
(define (lower-bound z)
  (min (car z)
       (cdr z)))
(define (upper-bound z)
  (max (car z)
       (cdr z)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

; 支持百分比
(define (make-center-percent c p)
  (let ((w (* c p)))
    (make-interval (- c w) (+ c w))))
(define (percent i)
  (/ (width i) (center i)))
; 测试
(define i (make-center-percent 6.8 0.1))
i
(percent i)
