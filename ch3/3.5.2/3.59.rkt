#lang scheme

(require (file "../3.5.1/stream.rkt"))

; 参考：https://github.com/jiacai2050/sicp/blob/master/exercises/03/3.59.scm

; a)
(define (integrate-series s)
  (div-streams s integers))
(define (div-streams s1 s2)
  (stream-map / s1 s2))
; test
(display-stream-top (integrate-series ones) 10)

; b)
(define sine-series (cons-stream 0
                                 (integrate-series cosine-series)))
(define cosine-series (cons-stream 1
                                   (integrate-series
                                    (scale-stream sine-series -1))))
; test
; 难道没有用 MIT-Scheme 导致运行出错！
(display-stream-top sine-series 10)
(display-stream-top cosine-series 10)