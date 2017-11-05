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
(define (solve-2nd a b y0 dy0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (add-streams (scale-stream dy a)
                            (scale-stream y b)))
  y)

; test
; 瞎写的测试
(stream-ref (solve-2nd 3 5 1 0 0.001)
            1000)