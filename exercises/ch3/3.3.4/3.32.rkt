#lang scheme

; 必须这样做原因：
;   事件会从发生地沿着线路向另一端传播，传播过程中
; 事件的回调方法不断被加入队列。后执行的方法可能会
; 改变先执行的结果。若不按照加入的先后顺序执行方法，
; 会导致结果不正确。


(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) (get-signal a2))))
      (after-delay
       and-gate-delay
       (lambda () (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

; 模拟与门 0,1 -> 1,0 的情况：
;
; 1) FIFO:
; (0, 1) initial: a1->0, a2->1, output->0
; a1 0->1, => (1,1) => (set-signal! output 1) in queue
; a2 1->0, => (1,0) => (set-signal! output 0) in queue
; time => and-gate-delay => delete (set-signal! output 1) & output->1
; => delete (set-signal! output 0) & output->0
; 结果正确无误！
;
; 2) LIFO:
; (0, 1) initial: a1->0, a2->1, output->0
; a1 0->1, => (1,1) => (set-signal! output 1) in queue
; a2 1->0, => (1,0) => (set-signal! output 0) in queue
; time => and-gate-delay => delete (set-signal! output 0) & output->0
; => delete (set-signal! output 1) & output->1
; 结果错误！！