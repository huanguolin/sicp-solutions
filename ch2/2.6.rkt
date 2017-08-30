#lang scheme
; 预定义函数
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
; one
(define one    
    (lambda (f) 
      (lambda (x) 
        (f x))))
; two
(define two    
    (lambda (f) 
      (lambda (x) 
        (f (f x)))))
; add
; 参考: http://community.schemewiki.org/?sicp-ex-2.6
(define (add a b)
  (lambda (f) 
    (lambda (x) 
      ((a f) ((b f) x)))))
