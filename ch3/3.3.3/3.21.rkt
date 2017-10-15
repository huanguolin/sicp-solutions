#lang scheme

; 1)
; Eva Lu 的意思是题中打印的信息是队列 (head tail)。
; 所以会出现打印的情况。至于 Ben 说最后一个数据项被
; 插入队列两次，原因是误以为 ((a b) b) 中两个 b 是两
; 次插入的结果。其实是 head -> (a b); tail -> b。
; 那么 (() b) 是由于删除最后一个项时，tail -> b，这
; 没有任何问题，因为队列为空是由 head 为空否决定的。

; 2)
(define (print-queue q)
  (display (front-ptr queue)))
