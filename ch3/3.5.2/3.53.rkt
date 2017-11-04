#lang scheme

(require (file "../3.5.1/stream.rkt"))

(define s (cons-stream 1 (add-streams s s)))

; 定义的流是： 1 2 4 8 16 ...
; 即： 2^n(n=0,1,2...)的数列

; test
(display-stream-top s 10)
