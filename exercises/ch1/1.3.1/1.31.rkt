#lang scheme
; a. 迭代版本
(define (product f a b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (+ a 1)
              (* result (f a)))))
  (iter a 1))

; 阶乘函数
(define (factorial n)
  (define (self x) x)
  (product self 1 n))
; 测试
(factorial 5)

; 计算 pi 的函数
(define (compute-pi n)
  (define (f x)
    (if (even? x)
        (/ x (- x 1))
        (/ (- x 1) x)))
  (* 4.0
     (product f 3 n)))
; 测试
(compute-pi 10000)

; b. 递归版本
(define (product-r f a b)
  (if (= a b)
      (f a)
      (* (f a)
         (product-r f (+ a 1) b))))

; 阶乘函数
(define (factorial-2 n)
  (define (self x) x)
  (product-r self 1 n))
; 测试
(factorial-2 5)

; 计算 pi 的函数
(define (compute-pi-2 n)
  (define (f x)
    (if (even? x)
        (/ x (- x 1))
        (/ (- x 1) x)))
  (* 4.0
     (product-r f 3 n)))
; 测试
(compute-pi-2 10000)