#lang scheme
; 预定义函数（来自2.2）
; line segment
(define (make-segment start
                      end)
  (cons start end))
(define (start-segment l)
  (car l))
(define (end-segment l)
  (cdr l))
; point
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))
; midpoint-segment
(define (midpoint-segment l)
  (define (average a b) (/ (+ a b) 2))
  (let ((start (start-segment l))
        (end (end-segment l)))
    (let ((x-mid (average (x-point start)
                          (x-point end)))
          (y-mid (average (y-point start)
                          (y-point end))))
      (make-point x-mid y-mid))))
; 计算线的长度
(define (length-segment line)
  (let ((start (start-segment line))
        (end (end-segment line)))
    (let ((w (- (x-point start)
                (x-point end)))
          (h (- (y-point start)
                (y-point end))))
      (sqrt (+ (expt w 2)
               (expt h 2))))))

; 第一种实现长方形的方式，用平行线表示
(define (make-rect pl1 pl2)
  (cons pl1 pl2))
(define (l1-rect rect)
  (car rect))
(define (l2-rect rect)
  (let ((pl1 (car rect))
        (pl2 (cdr rect)))    
    (make-segment (midpoint-segment pl1)
                  (midpoint-segment pl2))))
; 周长公式
(define (perimeter-rect rect)
  (let ((l1 (l1-rect rect))
        (l2 (l2-rect rect)))
    (* (+ (length-segment l1)
          (length-segment l2))
       2)))
; 面积公式
(define (area-rect rect)
  (let ((l1 (l1-rect rect))
        (l2 (l2-rect rect)))
    (* (length-segment l1)
       (length-segment l2))))
; 测试
(define a (make-point 0 0))
(define b (make-point 2 0))
(define c (make-point 2 1))
(define d (make-point 0 1))
(define ab (make-segment a b)) ; 长2
(define bc (make-segment b c)) ; 长1
(define cd (make-segment c d)) ; 长2
(define rect (make-rect ab cd)) 
(display "周长: ")
(perimeter-rect rect) ; (2+1)*2=6
(display "面积: ")
(area-rect rect) ; 2*1 = 2

; 第二种实现长方形的方式，用相邻的两条边
; 避免出现重定义的错误，下面代码注释掉了
;(define (make-rectangles vl1 vl2)
;  (cons vl1 vl2))
;(define (l1-rect rect)
;  (car rect))
;(define (l2-rect rect)
;  (cdr rect))
; 这样实现后，周长和面积方法均无需修改
