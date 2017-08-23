#lang scheme
;; 书中讲述的递归计算版本
(define (expt-r b n)
  (cond ((= 0 n) 1)
        ((even? n) (square (expt-r b (/ n 2))))
        (else (* b (expt-r b (- n 1))))))
;; test (expt-r 2 2) => 4
;; test (expt-r 2 10) => 1024
;; test (expt-r 2 11) => 2048

;; 题目要求的迭代计算版本
(define (expt-i b n)
  (define (iter a b n)
    (cond ((= 0 n) a)
          ((even? n) (iter a 
                           (square b)
                           (/ n 2)))
          (else (iter (* a b)
                      b
                      (- n 1)))))
  (iter 1 b n))
;; test (expt-i 2 2) => 4
;; test (expt-i 2 10) => 1024
;; test (expt-i 2 11) => 2048

;; 工具函数
(define (square x) (* x x))
;(define (even? n) ;;该函数已经内置，无需再定义
; (cond ((= 0 n) #t)
;       ((= 1 n) #f)
;       (else (even? (- n 2)))))