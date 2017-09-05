#lang scheme
; 参考: http://community.schemewiki.org/?sicp-ex-2.32
; 思想和换硬币类似，所有子集是下面两项的和:
; 1. 除了一个元素，剩下元素的所有子集
; 2. 除了一个元素,剩下元素的所有子集每个都加上第一个元素
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest 
                (map (lambda (x) (cons (car s) 
                                       x)) 
                     rest)))))
; test
(subsets (list 1 2 3)) 