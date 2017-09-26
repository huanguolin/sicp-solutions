#lang scheme

; 答案参考：http://community.schemewiki.org/?sicp-ex-2.86
; 重点: 将复数的基本计算过程用 integer & rational 的计算来代替。
;       这样可以方便以后修改为以另外一种数作为基本的运算数。
;       所以涉及到 integer 或者 rational 的运算都需要替换或修改
;       为基于 integer & rational 来计算。
; 需要替换的有： sine consine arctan sqrt square + - * /

;;; add into global 
(define (sine x) (apply-generic 'sine x)) 
(define (cosine x) (apply-generic 'cosine x)) 
(define (arctan x) (apply-generic 'arctan x)) 
(define (exp x y) (apply-generic 'exp x y)) 

;;; add into rational package  
(put 'sine '(number) (lambda (x) (tag (sin x)))) 
(put 'cosine '(number) (lambda (x) (tag (cos x)))) 
(put 'arctan '(number) (lambda (x) (tag (atan x)))) 
(put 'exp '(number number) (lambda (x y) (tag (expt x y)))) 

;;; complex-rect package  
(define (square x) (mul x x)) 
(define (sqrt x) (exp x 0.5)) 
(define (make-from-mag-ang r a) (cons (mul r (cosine a)) (mul r (sine a)))) 
(define (magnitude z) (sqrt (add (square (real-part z)) (square (imag-part z))))) 
(define (angle z) (arctan (div (imag-part z) (real-part z)))) 

;;; complex-polar package  
(define (real-part z) (mul (magnitude z) (cosine (angle z)))) 
(define (imag-part z) (mul (magnitude z) (sine (angle z)))) 

;;; complex package  
(define (add-complex z1 z2) 
 (make-from-real-imag (add (real-part z1) (real-part z2)) 
  (add (imag-part z1) (imag-part z2)))) 
(define (sub-complex z1 z2) 
 (make-from-real-imag (sub (real-part z1) (real-part z2)) 
  (sub (imag-part z1) (imag-part z2)))) 
(define (mul-complex z1 z2) 
 (make-from-mag-ang (mul (magnitude z1) (magnitude z2)) 
  (add (angle z1) (angle z2)))) 
(define (div-complex z1 z2) 
 (make-from-mag-ang (div (magnitude z1) (magnitude z2)) 
  (sub (angle z1) (angle z2)))) 
