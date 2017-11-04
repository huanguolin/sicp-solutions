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
