#lang scheme
;; 预定义函数
(define (double x) (* x 2))
(define (halve x) (/ x 2))

;; 题目要求的乘法函数
;;
;; 时间复杂度 Θ(logN)
;; 空间复杂度 Θ(1)
(define (mul a b)
  (define (add n x p)
    (cond ((or (= n 0) (= x 0)) p)
          ((even? n) (add (halve n)
                          (double x)
                          p))
          (else (add (- n 1)
                     x
                     (+ x p)))))
  (add a b 0))
;; test (mul 3 5) => 15
;; test (mul 19 0) => 0
;; test (mul 0 8) => 0
;; test (mul 1000 1000) => 1000000