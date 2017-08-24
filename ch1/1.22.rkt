#lang scheme
;; 工具函数
(define (square x) (* x x))
(define (divides? d x) (= (remainder x d) 0))

;; 书中正文预定义函数
(define (prime? n)
  (= n (smallest-divisor n)))
(define (smallest-divisor n) 
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n 
                              (+ test-divisor 1)))))
  (find-divisor n 2))

;; 题目中预定义函数
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))
(define (start-prime-test n start-time)
  (if (prime? n) 
      (report-prime (- (current-inexact-milliseconds) 
                                  start-time))
      (display " is not prime")))
(define (report-prime cost-time)
  (display " *** ")
  (display cost-time))