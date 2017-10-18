#lang scheme

; 1) 环境图略

; 2) 为什么 memo-fib 能以正比于 n 的步数计算出
;    第 n 个斐波那契数？
; 答： 因为对于每次计算 fib(n) = fib(n-1) + fib(n-2)
;     fib(n-1) 和 fib(n-2) 都可以从 table 中查到数值。
;     所以从 1-n 共需要 n 次。

; 3) 直接将 memo-fib 定义为 (memoize fib)，这一模式还能工作吗？
; 答： 不能。因为 memoize 的定义中，如果遇到没有计算过的数值，则会
;     调用 (f x)，这时即调用 (fib x)。