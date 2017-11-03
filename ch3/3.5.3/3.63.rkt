#lang scheme
; 参考： http://sicp.readthedocs.io/en/latest/chp3/63.html

(require (file "../3.5.1/stream.rkt"))

; pre-define
(define (average a b) (/ (+ a b) 2))
(define (sqrt-improve guess x)
  (average guess x))

; ======= 书中的定义 ========
(define (sqrt-stream x)
  (define guesses
    (stream-cons
     1.0
     (stream-map
      (lambda (guess) (sqrt-improve guess x))
      guesses)))  
  guesses)
; 假定 (define s (sqrt-steram 2))
; 依据 stream-ref 的定义，它是挨个向后查找。
; 那么:
; (stream-ref s 1) =>
; (stream-car (1.0 <promise:2>)) =>
; 1.0;
; 此时 s 为:
; (1.0 <promise:2>)

; (stream-ref s 2) =>
; (stream-car (stream-cdr (1.0 <promise:2>))) =>
; (stream-car (stream-cdr <promise:2>)) =>
; 从 guesses取出第一个来算第二个。
; (stream-car (3/2 <promise:3>)) => 
; 3/2
; 此时 s 为:
; (1.0 3/2 <promise:3>)

; (stream-ref s 3) =>
; (stream-car (stream-cdr (stream-cdr (1.0 3/2 <promise:3>)))) =>
; (stream-car (stream-cdr (3/2 <promise:3>))) =>
; 从 guesses 取出第二个来算第三个。
; (stream-car (7/4 <promise:4>)) => 
; 7/4
; 此时 s 为:
; (1.0 3/2 7/4 <promise:4>)

; 以上的推演，要注意 s 随着计算不断往下推进，计算过的值因使用memo-proc而
; 被记下，不用重复计算。

; ======= 题目中 Louis 的定义 =======
(define (louis-sqrt-stream x)
  (stream-cons
   1.0
   (stream-map
    (lambda (guess) (sqrt-improve guess x))
    (louis-sqrt-stream x))))
; 由于递推计算时用的是(louis-sqrt-stream x)，即新建另外一个流来计算
; 当前流的值。sqrt-stream 用的 guesses 是自身的这个流。
; 那么:
; 假定 (define ls (louis-sqrt-steram 2))
; 则有:
; (stream-ref ls 1) =>
; (stream-car (1.0 <promise:2>)) =>
; 1.0;
; 此时:
; ls => (1.0 <promise:2>)

; (stream-ref ls 2) =>
; (stream-car (stream-cdr (1.0 <promise:2>))) => 
; 用(louis-sqrt-steram 2)新建一个流，我们称它为ls'，
; 并取出 ls' 的第一个值来计算第二个值。
; (stream-car (3/2 <promise:3>)) =>
; 3/2
; 此时:
; ls => (1.0 3/2 <promise:3>)
; ls' => (1.0 <promise:2>)

; (stream-ref ls 3) 时， ls 的前两个数都不用计算，但是计算
; 第三个数的时候，即(stream-cdr <promise:3>)的求值时，需要
; ls' 的第二个值, 求 ls' 的第二个值，又用(louis-sqrt-steram 2)
; 新建一个流，我们称为 ls'', ls'' 返回它第一个值完成了 ls' 第二
; 个值的计算，从而 ls' 返回第二个值完成了 ls 第三个值的计算。
; 最终的得到结果 7/4, 此时:
; ls => (1.0 3/2 7/4 <promise:4>)
; ls' => (1.0 3/2 <promise:3>)
; ls'' => (1.0 <promise:2>)

; 可以看到相比书中的sqrt-stream低效了很多，不仅要计算更多步骤，还
; 要更多内存空间。


; ======= 如果 delay 不用 memo-proc 优化=======
; 如果memo-proc不用优化，两者的效率是一样的。
