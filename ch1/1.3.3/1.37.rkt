#lang scheme
; a. 先写一个迭代方法
(define (cont-frac n d k)
  (define (iter k product)
    (if (= 0 k)
        product
        (iter (- k 1)
              (/ (n k) (+ (d k) product)))))
  (iter k 0))
; 测试，结果趋于 φ -> 0.61803398874988948...
(define (n i) 1.0)
(define d n)
(cont-frac n d 10)
(cont-frac n d 11)
(cont-frac n d 12)
(cont-frac n d 20)
(cont-frac n d 30)
(cont-frac n d 50)
; 以上显示达到 4 位精度，只需要 k >= 11


; b. 改写为递归版本
(define (cont-frac-r n d k)
  (define (iter m)
    (if (> m k) 
        0
        (/ (n m)
           (+ (d m) (iter (+ m 1))))))
  (iter 1))
; 测试
(newline)
(display "递归版本: ")
(newline)
(cont-frac-r n d 10)
(cont-frac-r n d 11)
(cont-frac-r n d 12)
(cont-frac-r n d 20)
(cont-frac-r n d 30)
(cont-frac-r n d 50)