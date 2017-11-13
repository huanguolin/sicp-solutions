#lang scheme
;; cube root
(define (cbrt x)
  (cbrt-iter 1.0 x))
(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x) x)))
(define (good-enough? guess x)
  (< (abs (- guess 
             (improve guess x)))
     0.001))
(define (improve guess x)
  (/ (+ (* 2 guess)
        (/ x
           (squre guess)))
     3))
(define (cube x) (* x x x))
(define (squre x) (* x x))
;; test:
;; (cbrt 8) => 2.000004911675504
;; (cbrt 0.000001) => 0.010655395232020451
;; (cbrt 10000000000) => 2154.4346900485566