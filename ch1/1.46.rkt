#lang scheme
; 工具函数
(define (square x) (* x x))
(define (average a b) (/ (+ a b) 2))

; iter-improve
(define (iter-improve good-enough? 
                      improve)
  (define (iter guess) 
    (let ((next (improve guess)))
      (if (good-enough? guess)
          next
          (iter next))))
  iter)


; rewrite sqrt
(define (sqrt x)
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  ((iter-improve good-enough? improve) 1.0))
; test 
(display "test sqrt: ")
(newline)
(sqrt 2)
(sqrt 3)


; rewrite fixed-point
(define (fixed-point f first-guess)
    (define tolerance 0.00001)  
    (define (improve guess)
        (f guess))
    (define (close-enough? guess)
        (< (abs (- guess (improve guess))) tolerance))
    ((iter-improve close-enough? improve) first-guess))
; test
(define (new-sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 
               1.0))
(display "test fixed-point: ")
(newline)
(new-sqrt 2)
(new-sqrt 3)
