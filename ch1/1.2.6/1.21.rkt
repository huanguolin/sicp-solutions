#lang scheme
;; 工具函数
(define (square x) (* x x))
(define (divides? d x) (= (remainder x d) 0))

;; 书中定义的函数
(define (smallest-divisor n) 
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n 
                              (+ test-divisor 1)))))
  (find-divisor n 2))

;; 要求最小除数的几个值 199， 1999， 19999
;; (smallest-divisor 199) => 199
;; (smallest-divisor 1999) => 1999
;; (smallest-divisor 19999) => 7