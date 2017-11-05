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
; test
(display-stream-top sense-data 10)

; Alyssa 的定义 
(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector
    (stream-car input-stream)
    last-value)
   (make-zero-crossings
    (stream-cdr input-stream)
    (stream-car input-stream))))
(define zero-crossings
  (make-zero-crossings sense-data 0))
; test
(display-stream-top zero-crossings 10)

; Alyssa’s boss, Eva Lu Ator 的定义
(define zero-crossings-2
  (stream-map sign-change-detector
              sense-data
              (cons-stream 0 sense-data)))
; 注意上面最后一句(cons-stream 0 sense-data),
; 不能写为(stream-cdr sense-data), 原因是
; sign-change-detector 的第二个参数是 last-value
; test
(display-stream-top zero-crossings-2 10)