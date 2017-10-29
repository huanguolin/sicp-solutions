#lang scheme

; (define s (cons-stream 1 (add-streams s s)))
; 定义的流是： 1 2 4 8 16 ...
; 即： 2^n(n=0,1,2...)的数列

; 不知道为什么递归定义无穷流时用到stream-high-map就会
; 陷入死循环，最后一句没有任何输出
(require (file "../3.5.1/stream.rkt"))
(define (add-streams s1 s2)
  (stream-high-map + s1 s2))
(define s (stream-cons 1 (add-streams s s)))
;(cond-display-stream s (lambda (x) (< x 10)))
