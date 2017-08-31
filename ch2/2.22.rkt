#lang scheme
; 问题1:
; 因为这样会把输入list中越排在后面的数，
; 在输出的list中越排在前面。

; 问题2:
; 把 cons 参数的位置对调，仅仅是调整了
; list 的结构(参考下面图示)，但是前后关系仍然不变。
; (num, next)
;         |
;        (num, next)
;                |
;               (num, null)
; ==>>
; (next, num)
;   |
; (next, num)
;   |
; (next, num) 