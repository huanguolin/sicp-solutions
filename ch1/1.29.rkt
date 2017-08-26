#lang scheme
; 题目要求的积分函数(依据 Simpson’s Rule)
(define (integration f a b n)
  (define h (/ (- b a) n))
  (define (yk k) (f (+ a (* k h))))
  (define (sum-part-yk n)
    (define (iter product next)
      (if (< next 1)
          product
          (iter (+ product (yk next))
                (- next 2))))
    (+ (* 4 (iter 0 (- n (if (even? n) 1 2))))
       (* 2 (iter 0 (- n (if (even? n) 2 1))))))
  (* (/ h 3)
     (+ (yk 0)
        (yk n)
        (sum-part-yk n))))

; 根据题目要求求0-1直接的立方和,n分别取100和1000做两次
(define (cube x) (* x x x))
(integration cube 0 1.0 100)
(integration cube 0 1.0 1000)
; 得到结果非常精确,相比书中的积分函数,这个精度很高
; 0.25000000000000006
; 0.2500000000000002
; 不过这里貌似n大了反而精度低了？？

; 试试0-1的线性积分,理论值是1*1/2 = 0.5:
(define (line x) x)
(integration line 0 1.0 10)
(integration line 0 1.0 100)
; 0.5000000000000001
; 0.5
; 貌似n不用取太大就可以