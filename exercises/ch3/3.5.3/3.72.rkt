#lang scheme

(require (file "../3.5.1/stream.rkt"))
(require "./3.70.rkt")

(newline)
(newline)
(display "==========3.72==========")

(define (square x) (* x x))
(define (square-sum x y) (+ (square x)
                            (square y)))
(define ps (weighted-pairs integers
                           integers
                           (lambda (lst) (apply square-sum lst))))

; 受到3.74的启发,后面写了一个更加优雅的方法
(define (triple-square-sum)
  (define (iter s)
    (let ((v (stream-car s))
          (rest (stream-cdr s)))
      (let ((cs1 (apply square-sum v))
            (cs2 (apply square-sum (stream-car rest)))
            (cs3 (apply square-sum (stream-car (stream-cdr rest)))))
        (if (and (= cs1 cs2)
                 (= cs1 cs3))
            (cons-stream (list cs1
                               v
                               (stream-car rest)
                               (stream-car (stream-cdr rest)))
                         (iter (stream-cdr (stream-cdr rest))))
            (iter rest)))))
  (iter ps))
(define triple-square-sum-nums (triple-square-sum))
(display-stream-top triple-square-sum-nums 6)
;(325 (1 18) (6 17) (10 15))
;(425 (5 20) (8 19) (13 16))
;(650 (5 25) (11 23) (17 19))
;(725 (7 26) (10 25) (14 23))
;(845 (2 29) (13 26) (19 22))
;(850 (3 29) (11 27) (15 25))

;================= 更优雅 ===================
; 受到3.74的启发,应该在流这个抽象之上思考,
; 得到下面更加简洁的方法:
(define (triple-square-sum-proc v1 v2 v3)
  (let ((ss1 (apply square-sum v1))
        (ss2 (apply square-sum v2))
        (ss3 (apply square-sum v3)))
    (if (and (= ss1 ss2)
             (= ss1 ss3))
        (list ss1
              v1
              v2
              v3)
        '())))
(define triple-square-sum-numbers
  (stream-filter (lambda (x) (not (null? x)))
                 (stream-map triple-square-sum-proc
                             ps
                             (stream-cdr ps)
                             (stream-cdr (stream-cdr ps)))))
(display-stream-top  triple-square-sum-numbers 6)

