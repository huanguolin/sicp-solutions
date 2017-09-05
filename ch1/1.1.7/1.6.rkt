#lang scheme
;; sqrt
(define (sqrt x)
  (sqrt-iter 1.0 x))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
(define (good-enough? guess x)
  (< 
   (abs (- (squre guess) x))
   0.001))
(define (improve guess x) 
  (/ (+ guess 
        (/ x guess))
   2))
(define (squre x) (* x x))
;; test: (sqrt 2) => 1.4142156862745097

;; define new if: nif 
(define (nif predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; rewrite sqrt => nsqurt
(define (nsqrt x)
  (nsqrt-iter 1.0 x))
(define (nsqrt-iter guess x) 
  (nif (good-enough? guess x)
       guess
       (nsqrt-iter (improve guess x) x)))
;; test: (nsqrt 2) => 提示内存耗尽，计算终止
;; 肯定与nif是正则序还是应用序有关。
;;
;; 假设 nif 是正则序，那么就会先展开再按照cond-else
;; 语法计算,这样不会出现无法终止的问题。
;;
;; 假如 nif 是应用序，那么就要对参数求值，对于
;; (good-enough? 1.0 2) 很快能得到结果，但是对于
;; (nsqrt-iter (improve 1.0 2) 2) 则会陷入再次
;; 递归函数本身的死循环。
;; 
;; 所以问题的根本是 nif 采用应用序，无法先判断谓词条件
;; 再来决定求值，导致这里出现无限递归（结束递归必须要先
;; 判断递归条件,再决定是否继续)。
;; 由此看出 if 是采用正则序的，而且只有这样才真正可用。

