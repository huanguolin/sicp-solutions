#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-defined
(define (add-streams s1 s2) (stream-high-map + s1 s2))
(define fibs
  (stream-cons 0
               (stream-cons 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

; 1)
; 使用 add-streams 时，计算第n个斐波那契数需要
; (max 0 (n-1)) 次加法运算。

; 2)
; 如果简单的将 (delay <exp>) 定义为 (lambda () <exp>), 且
; 不使用 memo-proc 优化，那么根据斐波那契数的定义：
; fib(n)=fib(n-1)+fib(n-2)
; fib(n-1)与fib(n-2)只有一次计算没有重复，那么随着不断展开，
; 计算量将呈现指数增长。