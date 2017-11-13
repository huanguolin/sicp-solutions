#lang scheme
; 预定义函数
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))
(define (fold-right op initial sequence)
  (accumulate op initial sequence))

; 完善函数
(define (reverse1 sequence)
  (fold-right (lambda (a b) (append b (list a))) null sequence))
;test
(reverse1 (list 1 2 3 4))

(define (reverse2 sequence)
  (fold-left (lambda (a b) (cons b a)) 
             null 
             sequence))
;test
(reverse2 (list 1 2 3 4))