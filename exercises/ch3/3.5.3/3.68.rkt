#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define
(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))
; Louis define
(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
               t)
   (pairs (stream-cdr s) (stream-cdr t))))
; test
; 下面的代码都无法输出结果，最终内存耗尽!
(display-stream-top (pairs integers integers) 0) ; 第一个都无法输出！！
(display-stream-top (pairs integers integers) 3)

; 首先要注意 interleave 是个普通过程(相对 cons-stream 而言)，
; 普通过程的参数要按照应用序求值，即 (interleave s1 s2) 中，
; s1 和 s2 要先求值，对应到pairs中：
; (interleave
;   (stream-map (lambda (x) (list (stream-car s) x))
;               t)
;   (pairs (stream-cdr s) (stream-cdr t)))
; 第一个参数因为求值很快遇到delay，会返回 (v1, <promise:2>)
; 第二个参数求值时遇不到delay，且 s 和 t 是无穷流，则会陷入无限展开的死循环。
