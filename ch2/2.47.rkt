#lang scheme
; 预定义函数
(define (make-frame1 origin edge1 edge2)
  (list origin edge1 edge2))
(define (make-frame2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

; 补充选择函数
(define (origin-frame1 frame)
  (car frame))
(define origin-frame2 origin-frame1);可以复用
(define (edge1-frame1 frame)
  (cadr frame))
(define edge1-frame2 edge1-frame1); 可以复用
(define (edge2-frame1 frame)
  (cadr (cdr frame)))
(define (edge2-frame2 frame)
  (cdr (cdr frame)))