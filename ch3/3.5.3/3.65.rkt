#lang scheme

(require (file "../3.5.1/stream.rkt"))

(define (ln2-summands n)
  (cons-stream (/ 1.0 n) 
               (stream-map - (ln2-summands (+ n 1)))))
(define ln2-stream
  (partial-sums (ln2-summands 1)))
; test 
(display-stream-top ln2-stream 10)
