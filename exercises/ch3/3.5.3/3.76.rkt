#lang scheme

(require (file "../3.5.1/stream.rkt"))

(define (smooth s1 s2)
  (define (average x y) (/ (+ x y)
                           2.0))
  (stream-map average
              s1
              s2))

; test
(display-stream-top (smooth integers
                            (stream-cdr integers))
                    10)