#lang scheme

(require (file "../3.5.1/stream.rkt"))

(define (RC-circuit r c dt)
  (define (rcc i v0)
    (define rcs
      (cons-stream v0
                   (stream-map +
                               (scale-stream i (/ dt c))
                               (scale-stream i r)
                               rcs)))
    rcs)
  rcc)
; test
(define RC1 (RC-circuit 5 1 0.5))
(define RC1-vs (RC1 integers 1))
(display-stream-top RC1-vs 10)