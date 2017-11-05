#lang scheme

(require (file "../3.5.1/stream.rkt"))

; 补充的定义
(define (sign-change-detector v1 v2)
  (if (< (* v1 v2) 0)
      (if (< v1 0) -1 1)
      0))
(define max-sense-data 5)
(define (generate-sense-data)
  (let ((sign (if (< (random) 0.5) -1 1))
        (value (* (random) max-sense-data)))
    (cons-stream (* sign value)
                 (generate-sense-data))))
(define sense-data (generate-sense-data))

; Alyssa 计划是将前后两个值平均后形成一个新的
; 流，然后再按照之前的来处理。显然Louis Reasoner
; 在做平均值的时候，用的新流和旧流的值，所以不对！
; 修改Louis Reasoner的定义为：
(define (make-zero-crossings s1
                             s2
                             last-value)
  (let ((avpt (/ (* (stream-car s1)
                    (stream-car s2))
                 2)))
    (cons-stream (sign-change-detector avpt last-value)
                 (make-zero-crossings (stream-cdr s1)
                                      (stream-cdr s2)
                                      avpt))))
(define zero-crossings
  (make-zero-crossings sense-data
                       (stream-cdr sense-data)
                       0))
; test
(display-stream-top zero-crossings 10)