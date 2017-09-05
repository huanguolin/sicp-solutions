#lang scheme
(define (p) (p))
(define (test a b) 
  (if (= 0 a)
      a 
      b))

(test 0 p)
;; 使用应用序无法得到结果
;; (test 0 (p)) => 
;; (test 0 (p)) =>
;; ...
;; 使用正则序可以得到结果
;; (test 0 (p)) =>
;; (if (= 0 0) 0 (p)) =>
;; (if #t 0 (p)) =>
;; 0