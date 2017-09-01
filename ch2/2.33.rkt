#lang scheme
; 预定义函数
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

; use accumulate to define map
(define (map p sequence)
  (accumulate (lambda (x y) 
                (cons (p x) y)) 
              null 
              sequence))
; test 
(map (lambda (x) (* x x)) (list 1 2 3 4))

; use accumulate to define append
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
;test
(append (list 1 2) (list 3 4))

; use accumulate to define length
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 
              0 
              sequence))
; test
(length (list 1 2 3))