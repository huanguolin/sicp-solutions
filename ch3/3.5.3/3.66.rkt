#lang scheme

; 按照书中描述的表格和方法：
; A) 总的看(pairs S T),将它分为三个部分(S0,T0)/上半部/下半部。
; B) 默认第一个是(S0,T0)，后程序先取一个上半部的，再取一个下半部，然后上下循环。

; 解答：
; 1) 所以在(1, 100)时，上半部个数是99，下半部是98(因为先上后下),
;    总共(99+98)+1=198.
; 2) 在(100, 100)时，
;  (a) 将(100, 100)当做(S0,T0)，则上半部：0，下半部：0，总数：(0+0)+1=1=2^1-1
;  (b) 把(a)当做下半部，则上半部：1，总数：(1+1)+1=3=2^2-1
;  (c) 把(b)当做下半部，则上半部：3，总数：(3+3)+1=7=2^3-1
;  (d) ... 上半部：7，总数：(7+7)+1=15=2^4=1
;  ...
;  得出：f(i,j)=2^i-1, 当i==j时，所以(100, 100)时，总数: 2^100-1