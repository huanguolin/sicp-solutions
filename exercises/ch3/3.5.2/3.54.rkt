#lang scheme

(require (file "../3.5.1/stream.rkt"))

; mul-streams define
(define (mul-streams s1 s2)
  (stream-map * s1 s2))
; test
(define s (mul-streams integers integers))
(display-stream-top s 5)

; factorials define
(define factorials
  (cons-stream 1
               (mul-streams factorials
                            (integers-starting-from 2))))
; test
(display-stream-top factorials 5)