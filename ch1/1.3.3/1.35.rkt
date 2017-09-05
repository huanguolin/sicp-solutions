#lang scheme
(define (fixd-point f first-guess)
  (define (close-enough? a b)
    (< (abs (- a b)) 0.001))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; 黄金比例: φ = 1.618
(fixd-point (lambda (x) (+ 1 (/ 1 x)))
            1.0)
