#lang scheme
;; 要理解题目中提出算法的思路,并不容易。
;; 参考了几个答案后才理解，
;; 主要参考 http://sicp.readthedocs.io/en/latest/chp1/19.html

;; 现在自己再理理，如下：
;;
;; 1. 最基本的变换求 fib(n): 
;; (a, b) => (a+b, a)  
;; 初始值是 (1, 0), 这里 a -> fib(n+1), b -> fib(n)
;;
;; 我们把 (a, b) => (a+b, a) 这种变换称为 T,
;; 那么求 fib(n), 即要做 T(T(...(T))), 共 n 次, 
;; 然后取 b 的结果即可.我们可以把这个过程记为:
;; fib(n) => T^n
;;
;; 2. 题中提出对1中的调整方案:
;; (a, b) => (bq + a(p + q), bp + aq) 
;; 其中(p=0, q=1), 很显然，带入 q, p 的值后即为(a, b) => (a+b, a)
;; 
;; 把这种变换称之为 T[pq],
;; 则 fib(n) => T[pq]^n
;; 
;; 3. 根据以上进行推导:
;; T[pq]^n => (T[pq]^2)^(n/2) => (T[pq](T[pq]))^(n/2)
;; 假设 T[xy] = T[pq](T[pq]), 则有:
;; (T[pq](T[pq]))^(n/2) => T[xy]^(n/2)
;; 由此可以得出一种对数复杂度的算法，到这里后，关键是如何
;; 通过 (p, q) 得到 (x, y).
;; 
;; 我们可以通过 T[xy] = T[pq](T[pq]) 关系式来计算,
;; 首先：
;; T[xy] = (by+a(x+y), bx+ay)
;; T[pq](T[pq])= ((bp+aq)q+(bq+a(p+q))(p+q), (bp+aq)p+(bq+a(p+q))q)
;; T[pq](T[pq])= (b(2pq+q^2)+a(2q^2+2pq+p^2), b(p^2+q^2)+a(2pq+q^2))
;; 对应起来看:
;; by+a(x+y) => b(2pq+q^2)+a(2q^2+2pq+p^2)
;; bx+ay => b(p^2+q^2)+a(2pq+q^2)
;; 显然:
;; x = p^2+q^2
;; y = 2pq+q^2

;; 由以上便可以来编写新的 fib 函数了：
(define (fib n) 
  (define (iter a b p q n)
    (cond ((= n 0) b)
          ((even? n) (iter a 
                           b
                           (+ (* p p) (* q q))
                           (+ (* 2 p q) (* q q))
                           (/ n 2)))
          (else (iter (+ (* b q) (* a (+ p q)))
                      (+ (* b p) (* a q))
                      p
                      q
                      (- n 1)))))
  (iter 1 0 0 1 n))
;; test:
;; (fib 0) => 0
;; (fib 1) => 1
;; (fib 5) => 5
;; (fib 6) => 8
;; (fib 7) => 13
;; (fib 8) => 21
