#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define
(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC-circuit r c dt)
  (lambda (i v0)
    (add-streams (integral i v0 (/ dt c))
                 (scale-stream i r))))
; test
(define RC1 (RC-circuit 5 1 0.5))
(define RC1-vs (RC1 integers 1))
(display-stream-top RC1-vs 10)