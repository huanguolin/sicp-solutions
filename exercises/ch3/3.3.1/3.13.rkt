#lang scheme

; z's structure:
;     z
;     |
;     v
;    [a]-->[b]
;     ^     |
;     |     | 
;     --[c]<- 

; 如果计算 (last-pair z)，将陷入死循环

