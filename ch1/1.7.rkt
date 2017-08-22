#lang scheme
;; square root
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
;; test small or large number:
;; (sqrt 0.0001) => 0.03230844833048122
;; (sqrt 10000000000000) => 一直得不到结果
;;
;; 对于小数值，是由于预设的精度0.001相对于0.0001
;; 不足。而对于大数，预设的精度又相对太高（超过实际
;; 需要的精度没有必要），使计算在可接受的时间内
;; 难以逼近。

;; 新的精度判定：
;; 通过判断改善前后变化的值是否足够小来决定达标与否。
(define (change-small? a b)
  (< 
   (abs (- a b))
   0.001))
(define (nsqrt-iter guess x)
  (if (change-small? guess (improve guess x))
      guess
      (nsqrt-iter (improve guess x) x)))
(define (nsqrt x)
  (nsqrt-iter 1.0 x))
;; normal test: 
;; (nsqrt 2) => 1.4142156862745097
;; (sqrt 2) => 1.4142156862745097
;;
;; test small or large number:
;; (nsqrt 0.0001) => 0.010120218365353947
;; (nsqrt 10000000000000) => 3162277.6601683795
;; 改善的效果明显