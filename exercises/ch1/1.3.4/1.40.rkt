#lang scheme
; 预定义函数
; average-damp
(define (average-damp f)
  (define (average a b) 
    (/ (+ a b) 2))
  (lambda (x) (average x (f x))))
; fixed-point
(define (fixed-point f first-guess)
  (define (close-enough? a b)
    (< (abs (- a b)) 0.001))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
; test fixed-point 
(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
(define (cbrt x)
  (define (square a) (* a a))
  (fixed-point (average-damp (lambda (y) (/ x 
                                            (square y))))
               1.0))
; deriv
(define dx 0.00001)
(define (deriv g)
  (lambda (x) (/ (- (g (+ x 
                          dx)) 
                    (g x)) 
                 dx)))
; newtoms-method
(define (newtons-method g guess)
  (define (newton-transform g)
    (lambda (x) (- x 
                   (/ (g x) 
                      ((deriv g) x)))))
  (fixed-point (newton-transform g) guess))

; 题中要求的函数
(define (cubic a b c)  
  (define (square x) (* x x))
  (define (cube x) (* x (square x)))
  (lambda (x) (+ (cube x)
                 (* a (square x))
                 (* b x)
                 c)))
(newtons-method (cubic 1 1 1) 1) ; -1
(newtons-method (cubic 0 0 8) 1) ; -2

