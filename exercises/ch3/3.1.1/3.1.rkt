#lang scheme

(define (make-accumulator init-val)
  (lambda (val) 
    (begin (set! init-val (+ init-val val)) 
            init-val)))
; test
(define A (make-accumulator 5))
(A 10)
(A 10)
(define B (make-accumulator 2))
(B 10)
(B 10)
