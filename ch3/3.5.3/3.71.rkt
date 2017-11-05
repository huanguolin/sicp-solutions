#lang scheme

(require (file "../3.5.1/stream.rkt"))
(require "./3.70.rkt")

(newline)
(newline)
(display "==========3.71==========")

(define (cube x) (* x x x))
(define (cube-sum x y) (+ (cube x)
                          (cube y)))
(define ps (weighted-pairs integers
                           integers
                           (lambda (lst) (apply cube-sum lst))))

; 这里是第一次写出来的方法，后面有更优雅的方法
(define (Ramanujan)
  (define (iter s)
    (let ((v (stream-car s))
          (rest (stream-cdr s)))
      (let ((cs1 (apply cube-sum v))
            (cs2 (apply cube-sum (stream-car rest))))
        (if (= cs1 cs2)
            (cons-stream (list cs1 v (stream-car rest))
                         (iter (stream-cdr rest)))
            (iter rest)))))
  (iter ps))
(define Ramanujan-nums (Ramanujan))
(display-stream-top Ramanujan-nums 6)
;(1729 (1 12) (9 10))
;(4104 (2 16) (9 15))
;(13832 (2 24) (18 20))
;(20683 (10 27) (19 24))
;(32832 (4 32) (18 30))
;(39312 (2 34) (15 33))

;================= 更优雅 ===================
; 受到3.74的启发，应该在流这个抽象之上思考,
; 得到下面更加简洁的方法:
(define (ramanujan-proc v1 v2)
  (let ((cs1 (apply cube-sum v1))
        (cs2 (apply cube-sum v2)))
    (if (= cs1 cs2)
        (list cs1 v1 v2)
        '())))
(define ramanujan-nums
  (stream-filter (lambda (x) (not (null? x)))
                 (stream-map ramanujan-proc
                             ps
                             (stream-cdr ps))))

(display-stream-top ramanujan-nums 6)
; 这种方法思路清晰，而且对ramanujan-proc进行简单的修改
; 就可得到仅仅是Ramanujan数值,省略分解形式的结果。