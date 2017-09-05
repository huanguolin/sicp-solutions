#lang scheme
; 预定义函数
(define (square x) (* x x))

; 修改 expmod 
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((nontrivial-square-root? base m) 0)  
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))
(define (nontrivial-square-root? base m)
  (cond ((or (= base 1)
             (= base (- m 1))) false)
        ((= 1 (remainder (square base) m)) true)
        (else false)))

; 修改 fast-prime? 函数
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))
(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))
; 先测试 Carmichael 数字:
(display "Test Carmichael numbers:")
(newline)
(fast-prime? 561 10)
(fast-prime? 1105 10)
(fast-prime? 1729 10)
(fast-prime? 2465 10)
(fast-prime? 2821 10)
(fast-prime? 6601 10)
; 测试10以内的数:
(define (range-test min max)
  (display "Test ")
  (display min)
  (display "-")
  (display max)  
  (display ":")
  (newline)
  (define (iter min max)
    (if (> min max) 
        (display "done!")
        (begin (display min)
               (display " : ")
               (display (fast-prime? min 10))
               (newline)
               (iter (+ min 1) max))))
  (iter min max))
(range-test 2 10)
