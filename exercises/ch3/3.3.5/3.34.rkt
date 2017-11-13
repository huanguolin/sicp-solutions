#lang scheme

; 缺陷是：无法通过设置 b 的值来求出 a.

; test
(require "./connector.rkt"
         "./multiplier.rkt"
         "./probe.rkt")
(define (squarer a b)
  (multiplier a a b))

(define A (make-connector))
(define B (make-connector))
(squarer A B)
(probe "A" A)
(probe "B" B)

; a -> b, ok
(set-value! A 5 'user)

; b -> a, failed
(forget-value! A 'user)
(set-value! B 16 'user)