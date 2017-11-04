#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-defined
(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

; s1 输出 1, 4, 2, 8, 5, 7, 1, 4, 2, 8, 5, 7, 1, ....
; s2 输出 3, 7, 5, 0, 0, 0, 0 ....
(define s1 (expand 1 7 10))
(define s2 (expand 3 8 10))

; test
(display-stream-top s1 15)
(display-stream-top s2 15)
