#lang scheme

(require "./connector.rkt"
         "./adder.rkt"
         "./multiplier.rkt"
         "./constant.rkt"
         "./probe.rkt")

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))
(define (c- sum x)
  (let ((y (make-connector)))
    (adder x y sum)
    y))
(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))
(define (c/ mul x)
  (let ((y (make-connector)))
    (multiplier x y mul)
    y))
(define (cv v)
  (let ((x (make-connector)))
    (constant v x)
    x))

; test 
(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))
(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(probe "C" C)
(probe "F" F)

; C -> F
(set-value! C 15 'user)

; F -> C
(forget-value! C 'user)
(set-value! F 59 'user)