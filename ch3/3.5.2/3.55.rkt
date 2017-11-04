#lang scheme

(require (file "../3.5.1/stream.rkt"))

 (define (partial-sums s) 
   (add-streams s (cons-stream 0 (partial-sums s)))) 
; test
(define s (partial-sums integers))
(display-stream-top s 10)