#lang scheme
; 工具函数
; from 1.42
(define (compose f1 f2) 
  (lambda (x) (f1 (f2 x))))
; from 1.43
(define (repeated f n)
  (cond ((= n 0) (lambda (x) (f x)))
        ((even? n) (repeated (compose f f) 
                             (- n 2)))
        (else (compose f 
                       (repeated f 
                                 (- n 1))))))
; from 1.40
(define (average-damp f)
  (define (average a b) 
    (/ (+ a b) 2))
  (lambda (x) (average x (f x))))
; from 1.40
(define (fixed-point f first-guess)
  (define (close-enough? a b)
    (< (abs (- a b)) 0.00001))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))  
  (try first-guess))

; 关于通过实验得出需要平均阻尼的次数,
; 请参考 http://sicp.readthedocs.io/en/latest/chp1/45.html
; 结论是: 需要logN次【向下取整, 底数是2】
(define (average-damp-times n)
  (floor (/ (log n) (log 2))))
(define (average-damp-n-times f n)
  ((repeated average-damp n) f))
; nth-root 
(define (nth-root n)
  (lambda (x) 
    (fixed-point 
     (average-damp-n-times
      (lambda (y) (/ x (expt y (- n 1))))
      (average-damp-times n))               
     1.0)))
; test
((nth-root 2) 2)
((nth-root 5) 32)