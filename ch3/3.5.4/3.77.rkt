#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define 
(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

; require
(define (integral delay-integrand initial-value dt)
  (cons-stream
   initial-value
   (let ((integrand (force delay-integrand)))
     (if (stream-null? integrand)
         the-empty-stream
         (integral (delay (stream-cdr integrand))
                   (+ (* dt (stream-car integrand))
                      initial-value)
                   dt)))))
; test
(stream-ref (solve (lambda (y) y) 1 0.001)
            1000)
; 2.716923932235896

