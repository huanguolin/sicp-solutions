#lang scheme

; (define x (stream-map show (stream-enumerate-interval 0 10)))
; 将返回：
; 0
; value: x

; (stream-ref x 5)
; 将返回：
; 1
; 2
; 3
; 4
; 5
; value: 5

; (stream-ref x 7)
; 将返回：
; 6
; 7
; value: 7

; ============== test ================
(require "./stream.rkt")
(define (display-line x) (newline) (display x))
(define (show x)
  (display-line x)
  x)
(define x (stream-map
           show
           (stream-enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)