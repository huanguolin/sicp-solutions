#lang scheme

(require (file "../3.5.1/stream.rkt"))

; a)
; 方法1
(define (integrate-series args)
  (define (iter s cnt)
    (stream-cons (* (/ 1 cnt)
                    (stream-car s))
                 (iter (stream-cdr s) (+ cnt 1))))
  (iter args 1))
; 方法2
(define (integrate-series2 s)
  (stream-high-map / s integers))
(define integers (integers-starting-from 1))
; test
(define ones (stream-cons 1 ones))
(define s1 (integrate-series ones))
(cond-display-stream s1 (lambda (x) (> x (/ 1 10))))
(define s2 (integrate-series2 ones))
(cond-display-stream s2 (lambda (x) (> x (/ 1 10))))

; b)
(define (scale-stream s factor)
  (stream-map (lambda (x) (* s factor)) s))
(define sine-series (stream-cons 0 (integrate-series cosine-series)))
(define cosine-series (stream-cons 1 (integrate-series (scale-stream sine-series -1))))