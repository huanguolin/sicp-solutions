#lang scheme
; ~~~~~~~~~a. 递归版本~~~~~~~~~
(define (accumulate combiner
                    null-value
                    term
                    a
                    next
                    b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner
                            null-value
                            term
                            (next a)
                            next
                            b))))

; 用 accumulate 实现 sum:
(define (sum term a next b)
  (define (combiner x y) (+ x y))
  (accumulate combiner 0 term a next b))
; 测试 sum
(define (sum-integer a b)
  (define (self x) x)
  (define (next x) (+ x 1))
  (sum self a next b))
(sum-integer 1 10) ; 55
(sum-integer 1 100) ; 5050

; 用 accumulate 实现 product:
(define (product f a b)
  (define (combiner x y) (* x y))
  (define (next x) (+ x 1))
  (accumulate combiner 1 f a next b))
; 测试 product
(define (factorial n)
  (define (self x) x)
  (product self 1 n))
(factorial 5) ; 120
(factorial 6) ; 720

; ~~~~~~~~~~~~b. 迭代版本~~~~~~~~~~~~~~
(define (accumulate-i combiner
                      null-value
                      term
                      a
                      next
                      b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a)
                                 result))))
  (iter a null-value))

; 用 accumulate-i 实现 sum2:
(define (sum2 term a next b)
  (define (combiner x y) (+ x y))
  (accumulate-i combiner 0 term a next b))
; 测试 sum2
(define (sum-integer2 a b)
  (define (self x) x)
  (define (next x) (+ x 1))
  (sum2 self a next b))
(sum-integer2 1 10) ; 55
(sum-integer2 1 100) ; 5050

; 用 accumulate 实现 product2:
(define (product2 f a b)
  (define (combiner x y) (* x y))
  (define (next x) (+ x 1))
  (accumulate-i combiner 1 f a next b))
; 测试 product2
(define (factorial2 n)
  (define (self x) x)
  (product2 self 1 n))
(factorial2 5) ; 120
(factorial2 6) ; 720