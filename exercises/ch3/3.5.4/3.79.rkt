#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define
(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream
     initial-value
     (let ((integrand (force delayed-integrand)))
       (add-streams (scale-stream integrand dt) int))))
  int)

; require
(define (solve-2nd f y0 dy0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)
; test
; 瞎写的测试
(stream-ref (solve-2nd (lambda (x y) (* x y)) 1 1 0.001)
            1000)