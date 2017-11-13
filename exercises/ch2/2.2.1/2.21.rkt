#lang scheme
; tools procedure
(define (square x) (* x x))

; 1. 原始方式
(define (square-list-origin items)
  (if (null? items)
      null
      (cons (square (car items))
            (square-list-origin (cdr items)))))
; test
(square-list-origin (list 1 2 3 4))

; 2. 借助 map
(define (square-list items)
  (map square items))
; test
(square-list (list 1 2 3 4))