#lang scheme
; 预定义函数
(define (cont-frac n d k)
  (define (iter k product)
    (if (= 0 k)
        product
        (iter (- k 1)
              (/ (n k) (+ (d k) product)))))
  (iter k 0))

; 定义 n & d 过程:
(define (n i) 1.0)
(define (d i) 
  (let ((r (remainder i 3))
        (q (exact-floor (/ i 3))))
    (if (= r 2)
        (+ 2 (* 2 q))
        1)))
; 测试 d:
(define (test-d n)
  (display "test d: ")
  (newline)
  (define (iter i)
    (if (> i n)
        (display "done!")
        (begin 
          (display i)
          (display "  -> ")
          (display (d i))
          (newline)
          (iter (+ i 1)))))
  (iter 1))
(test-d 15)

; 逼近 e -> 2.71828182845...
(newline)
(display "e: ")
(newline)
(+ (cont-frac n d 10) 2)
(+ (cont-frac n d 15) 2)
(+ (cont-frac n d 50) 2)
