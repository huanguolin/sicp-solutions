#lang scheme

; ============================================
; 为了检验书中练习题，这里实现了书中提到 stream
; 相关的基础函数. 不过书中的 cons-stream 未能实现，
; 所以需要用 stream-cons 代替！
; ============================================


; 不要用这个语言包,它与书中定义的特性不符！！
;(require racket/stream)
; 注意 srfi/41 的特性也不相符
(require srfi/40)

(provide stream-cons
         stream-car
         stream-cdr
         the-empty-stream
         stream-null?
         stream-ref
         stream-map
         stream-for-each
         stream-filter
         stream-enumerate-interval
         display-stream)


; ==== basic define ====
; 无法定义下一行,因为stream-cons是个特殊的过程,
; 它的参数求值不是应用序,而是正则序!这有别于普通
; 的过程
; (define cons-stream stream-cons)
(define the-empty-stream stream-null)

; ==== list function ===
; ref/map/for-each/filter/enumerate-interval 
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (stream-cons (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))
(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (stream-cons (stream-car stream)
                      (stream-filter
                       pred
                       (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))
(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (stream-cons
       low
       (stream-enumerate-interval (+ low 1) high))))

; ==== util define ====
(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x) (newline) (display x))

