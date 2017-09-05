#lang scheme
; 预定义函数
(define (make-interval a b) (cons a b))
(define (lower-bound z)
  (min (car z)
       (cdr z)))
(define (upper-bound z)
  (max (car z)
       (cdr z)))
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

; get width of intervel
(define (width-of-interval x)
  (/ (- (upper-bound x) 
        (lower-bound x))
     2))

; 推导出 x y 和的 width 仅仅与 x y 的 width 有关: 
;(width-of-interval (add-interval x y))
; =>
;(/ (- (upper-bound (add-interval x y)) 
;      (lower-bound (add-interval x y)))
;   2) 
; 其中 (add-interval x y) 可以展开为:
; (make-interval (+ (lower-bound x) (lower-bound y))
;                (+ (upper-bound x) (upper-bound y)))
; =>
;(/ (- (+ (upper-bound x) (upper-bound y))) 
;      (+ (lower-bound x) (lower-bound y))
;   2)
; =>
;(/ (+ (- (upper-bound x) (lower-bound x)) 
;      (- (upper-bound y) (lower-bound y)))
;   2)
; =>  
;(/ (+ (* (width-of-interval x) 2)
;      (* (width-of-interval y) 2))
;   2)
; => 
;(+ (width-of-interval x)
;   (width-of-interval y))
; 由以上可以得到
(define (width-of-sum-interval x y)
  (+ (width-of-interval x)
     (width-of-interval y)))
; 测试
(define x (make-interval 4 9))
(define y (make-interval 2 6))
(width-of-sum-interval x y)
(width-of-interval (add-interval x y))

; 证明乘法不适用这个，略。简单讲就是乘法和基数有关系。