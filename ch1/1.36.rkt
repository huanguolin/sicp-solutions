#lang scheme
; 修改 fixd-point，使它能打印逼近过程
(define (fixd-point f first-guess)
  (define (close-enough? a b)
    (< (abs (- a b)) 0.001))
  (define (try guess)
    (let ((next (f guess)))
      (display "Guess: ")
      (display guess)
      (display " Next: ")
      (display next)
      (newline)
      (if (close-enough? guess next)
          (begin 
            (display "Result: ") 
            (display next))
          (try next))))
  (try first-guess))

; x -> log(1000)/log(x)
(fixd-point (lambda (x) (/ (log 1000) (log x)))
            10.0)