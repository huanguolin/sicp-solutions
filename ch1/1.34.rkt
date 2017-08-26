#lang scheme
; 会发生错误:
; (f f) =>
; (f 2) =>
; Error: f 期待一个过程作为参数

; 测试如下:
(define (f g) (g 2))
(f f)