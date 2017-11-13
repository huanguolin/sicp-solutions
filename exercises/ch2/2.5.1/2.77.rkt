#lang scheme

; 1. 为什么这样做是可行的？
;    因为 real-part/imag-part/magnitude/angle 都定义的有
;    通用操作方法，只不过之前没有定义复数类型用什么方法。
;    现在添加（安装）上复数操作方法即可。apply-generic 会
;    拿到新注册的方法。
;
; 2. (magnitude z) 的求值过程。apply-generic 被调用几次？
;    每次调用中分派的是那个过程？
;    (magnitude z) ->
;    (apply-generic 'magnitude z) ->
;    ((get 'magnitude (operator z) (operands z))) ->
;    ((get 'magnitude '(complex)) '(rectangular 3 4)) ->
;    (magnitude '(rectangular 3 4)) ->
;    (apply-generic 'magnitude '(rectangular 3 4)) ->
;    ((get 'magnitude '(rectangular)) '(3 4)) ->
;    (sqrt (+ (square (real-part '(3 4)))
;             (square (imag-part '(3 4))))) ->
;    (sqrt (+ (square 3)
;             (square 4))) ->
;    (sqrt (+ 9 16)) ->
;    (sqrt 25) ->
;    5
;    
;    apply-generic 被调用2次。每次调用分派的看上面的分解。
; 
