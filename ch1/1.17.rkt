#lang scheme
;; 题目中预定义的函数
(define (double x) (* x 2))
(define (halve x) (/ x 2))

;; 题目要求的乘法函数
;; 时间和空间复杂度均为Θ(logN)
;;
;; （因为题目要求类似 fast-expt 的复杂度，
;; 他说的 fast-expt 是文章中示例的那个！）
(define (mul a b)
  (cond ((= a 0) 0)
        ((= a 1) b)
        ((even? a) (mul (halve a) (double b)))
        (else (+ b (mul (- a 1) b)))))
;; test (mul 3 5) => 15
;; test (mul 19 0) => 0
;; test (mul 0 8) => 0
;; test (mul 1000 1000) => 1000000