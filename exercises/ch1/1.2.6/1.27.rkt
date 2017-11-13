#lang scheme
; 预定义函数
(define (square x) (* x x))
(define (divides? d x) (= (remainder x d) 0))
(define (get-cur-ms) (current-inexact-milliseconds))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))
(define (next n)
  (cond ((= n 2) 3)
        ((odd? n) (+ n 2))
        (else (+ n 1))))
(define (prime? n)
  (= n (smallest-divisor n)))
(define (smallest-divisor n) 
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (find-divisor n 2))

; 题目要求的函数
(define (Carmichael? n)
  (define (one-test a n)
    (= (expmod a n n) a))
  (define (iter a n)
    (cond ((< n 2) #f)
          ((= a n) (not (prime? n)))
          ((one-test a n) (iter (+ a 1) n))
          (else #f)))
  (iter 2 n))

; 用 Carmichael? 来验证:
; 561, 1105, 1729, 2465, 2821, and 6601
(Carmichael? 561)
(Carmichael? 1105)
(Carmichael? 1729)
(Carmichael? 2465)
(Carmichael? 2821)
(Carmichael? 6601)
(Carmichael? 10)
(Carmichael? 2)