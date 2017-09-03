#lang scheme
; 预定义函数
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

; redefine count-leaves
(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (x)
                     (cond ((null? x) 0)
                           ((pair? x) (count-leaves x))
                           (else 1)))
                   t)))
; test
(count-leaves (list (list 1 2) (list 3 4) 5)); 5
(count-leaves (list (list) (list 3 4) (list))); 2