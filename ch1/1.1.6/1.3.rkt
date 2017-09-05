#lang scheme
(define (square x) (* x x))
(define (sum-of-square a b) 
  (+ (square a)
     (square b)))
(define (max a b)
  (if (> a b) 
      a 
      b))

(define (largest-two-square-sum a b c)
  (if (= a (max a b))
      (sum-of-square a (max b c))
      (sum-of-square b (max a c))))
;; input 1, 2, 3 => 13
;; input 3, 2, 1 => 13
;; input 3, 1, 2 => 13