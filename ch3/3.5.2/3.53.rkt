#lang scheme

; (define s (cons-stream 1 (add-streams s s)))
; 定义的流是： 1 2 4 8 16 ...
; 即： 2^n(n=0,1,2...)的数列
