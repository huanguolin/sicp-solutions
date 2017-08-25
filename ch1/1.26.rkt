#lang scheme
; 预定义函数
(define (square x) (* x x))

; 【预分析】
; 现在假设有: a * b = c，
; 求 (a * b)^2
;
; 注意一下两种运算方式的差异
;
; 1) 调用 square 函数
; (square (* a b)) =>
; (square c) =>
; (* c c)
;
; 2) 直接使用乘法
; (* (*a b) (* a b)) =>
; (* c (* a b)) =>
; (* c c)
;
; 由以上过程可以看出:
; 直接使用乘法会多计算一次 (* a b)

; 【回归问题】
; 回到1.26的问题中，题中显示的差异代码如下:
;
; 1) 使用 square 函数
; (remainder (square (expmod base (/ exp 2) m))
;            m))
;
; 2) 直接使用乘法
; (remainder (* (expmod base (/ exp 2) m)
;               (expmod base (/ exp 2) m))
;            m))
; 
; 所以每做一次运算，后者要多算一次表达式:
; (expmod base (/ exp 2) m)
;
; 【分析】
; 那么原本算法是:
; T^n => (T^(n/2))^2 => Θ(logN)
; 直接使用乘法导致:
; T^n => T^(n/2)*T^(n/2) => Θ(N)
;