#lang scheme

(define f-value 0)
(define (f v) 
  (let ((ret f-value))
    (begin (set! f-value v)
           ret)))

; test 
(+ (f 0) (f 1)) ; expect 0

(set! f-value 0)
(+ (f 1) (f 0)) ; expect 1
