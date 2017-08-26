#lang scheme
; 将书中的递归方式求和函数改为迭代方式:
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

; 测试
(define (self x) x)
(define (next x) (+ x 1))
(sum self 0 next 10) ; 输出55
(sum self 1 next 100) ; 输出5050