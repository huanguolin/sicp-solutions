#lang scheme
; 预定义函数
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

; 完善函数
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))
; test
(define s (list (list 1 2 3)
                (list 4 5 6)
                (list 7 8 9)
                (list 10 11 12)))
(accumulate-n + 0 s) ; (22 26 30)