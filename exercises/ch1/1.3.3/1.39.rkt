#lang scheme
; 更改 cont-frac 函数
(define (cont-frac n d k)
  (define (iter k product)
    (if (= 0 k)
        product
        (iter (- k 1)
              (/ (n k) (+ (d k) product)))))
  (iter k 0))

; 题中要求的 tan(x) 函数:
(define (tan-cf x k) 
  (cont-frac (lambda (i) (if (= i 1) 
                             x 
                             (- (* x x))))
             (lambda (i) (- (* 2 i) 
                            1))
             k))
; 测试（角度[a] -> 弧度[r]: r = (pi * a) / 180）
(tan-cf 0 50) ; 0度-> 0
(tan-cf (/ pi 4) 50) ; 45度-> 1
(tan-cf (/ pi 3) 50); 60度-> 3^(1/2)=1.732
(tan-cf (/ pi 2) 50); 90度-> 正无穷
(tan-cf (/ pi (/ 3 2)) 50); 135度-> -1.732