#lang scheme
; 预定义函数
(define (make-interval a b) (cons a b))
(define (lower-bound z)
  (min (car z)
       (cdr z)))
(define (upper-bound z)
  (max (car z)
       (cdr z)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
(define (make-center-percent c p)
  (let ((w (* c p)))
    (make-interval (- c w) (+ c w))))
(define (percent i)
  (/ (width i) (center i)))
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; 使用 make-center-percent 的方式表示 interval,
; 并假定全部是正数，则可以有:
; X = (x, p)
; Y = (y, q)
; Z = (z, r) = A * B, and
; w is width of Z, c is center of Z.
;
; 则:
; r = w / c
; w = (Zmax - Zmin) / 2
; c = (Zmax + Zmin) / 2
; Zmax = (x+x*p)*(y+y*q) = xy(1+p+q+pq)
; Zmin = (x-x*p)*(y-y*q) = xy(1-p-q+pq)
;
; ==>
; w = (xy(1+p+q+pq)-xy(1-p-q+pq))/2 = xy(2p+2q)/2 = xy(p+q)
; c = (xy(1+p+q+pq)+xy(1-p-q+pq))/2 = xy(2+2pq)/2 = xy(1+pq)
;
; ==>
; r = (xy(p+q))/(xy(1+pq)) = (p+q)/(1+pq)

; 测试
(define p 0.2)
(define q 0.3)
(define X (make-center-percent 5 p))
(define Y (make-center-percent 7 q))
(define Z (mul-interval X Y))
(percent Z)
(/ (+ p q) (+ 1 (* p q)))
