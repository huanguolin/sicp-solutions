#lang scheme
; 只写一个迭代版本的:
(define (filtered-accumulate combiner
                             init-value
                             term
                             a
                             next
                             b
                             filter)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (if (filter a)
                  (combiner result (term a))
                  result))))
  (iter a init-value))

; 实现要求的特殊求值函数:

; 工具函数
(define (square x) (* x x))
(define (next n)
  (cond ((= n 2) 3)
        ((odd? n) (+ n 2))
        (else (+ n 1))))
(define (prime? n)
  (define (divides? d x) (= (remainder x d) 0))
  (define (smallest-divisor n) 
    (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (next test-divisor)))))
    (find-divisor n 2))
  (= n (smallest-divisor n)))
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


; a. 指定范围内素数的平方和
(define (sum-prime-square a b)
  (define (combiner x y) (+ x y))
  (filtered-accumulate combiner
                       0
                       square
                       a
                       next
                       b
                       prime?))
; test
(display "2-10以内的素数平方和(理论值 87): ")
; 2^2+3^2+5^2+7^2 = 4+9+25+49 = 87
(sum-prime-square 2 10)

; b. 得到所有小于n且与n互质的正整数
(define (product-less-and-prime-to-it n)
  (define (combiner x y) (display " "))
  (define (next x) (+ x 1))
  (define (prime-each? x) (= 1 (gcd x n)))
  (filtered-accumulate combiner
                       0
                       display
                       1
                       next
                       (- n 1)
                       prime-each?))
; test
(display "小于且互质于10的数(理论值 1 3 7 9): ")
(product-less-and-prime-to-it 10)