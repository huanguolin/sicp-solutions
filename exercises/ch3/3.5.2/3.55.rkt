#lang scheme

(require (file "../3.5.1/stream.rkt"))

; 这种方式没有后面这种优雅
;(define (partial-sums s)
;  (cons-stream (stream-car s)
;               (add-streams (partial-sums s)
;                            (stream-cdr s))))
(define (partial-sums s) 
  (add-streams s (cons-stream 0 (partial-sums s)))) 
; test
(define s (partial-sums integers))
(display-stream-top s 10)