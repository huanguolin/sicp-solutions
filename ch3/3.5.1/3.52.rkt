#lang scheme

(define sum 0)
; sum => 0

(define (accum x) (set! sum (+ x sum)) sum)
; sum => 0

(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20)))
; sum => 1
; seq => (1 (stream-map accum (stream-enumerate-interval 2 20)) ) 

(define y (stream-filter even? seq))
; sum => 6
; seq => (1 3 6 (stream-map accum (stream-enumerate-interval 4 20)))
; y => (6 (stream-filter even? seq:4))

(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq))
; sum => 10
; seq => (1 3 6 10 (stream-map accum (stream-enumerate-interval 5 20)))
; z => (10 (stream-filter (lambda (x) (= (remainder x 5) 0)) seq:5))
; y => (6 (stream-filter even? seq:4))

(stream-ref y 7)
; sum => 136
; seq => (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136
;           (stream-map accum (stream-enumerate-interval 17 20))
; y => (6 10 28 36 66 78 120 136 (stream-filter even? seq:17))
; z => (10 (stream-filter (lambda (x) (= (remainder x 5) 0)) seq:5))
; 打印信息为： 136 

(display-stream z)
; sum => 210
; seq => (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210)
; z => (10 15 45 55 105 120 190 210)
; y => (6 10 28 36 66 78 120 136 (stream-filter even? seq:17))
; 打印信息为：
; 10
; 15
; 45
; 55
; 105
; 120
; 190
; 210

;================================================
; 如果 (delay <exp>) 实现为 (lambda () <exp>)
; 则有很多重复计算，这里由于使用赋值，会导致结果异常，显示如下：
(define sum 0)
; sum => 0

(define (accum x) (set! sum (+ x sum)) sum)
; sum => 0

(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20)))
; sum => 1
; seq => (1 (stream-map accum (stream-enumerate-interval 2 20)) ) 

(define y (stream-filter even? seq))
; sum => 6
; seq(y) => (1 3 6 (stream-map accum (stream-enumerate-interval 4 20)))
; y => (6 (stream-filter even? seq(y):4))

(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq))
; sum => (6+2+3+4) = 15
; seq(z) => (1 8 11 15 (stream-map accum (stream-enumerate-interval 5 20)))
; z => (15 (stream-filter (lambda (x) (= (remainder x 5) 0)) seq(z):5))
; y => (6 (stream-filter even? seq(y):4))

(stream-ref y 7)
; sum => 162
; seq(y) => (1 3 6 19 24 30 37 45 54 64 75 87 100 114 129 145 162
;           (stream-map accum (stream-enumerate-interval 18 20))
; y => (6 24 30 54 64 100 114 162 (stream-filter even? seq(y):18))
; z => (15 (stream-filter (lambda (x) (= (remainder x 5) 0)) seq(z):5))
; 打印信息为: 162 

(display-stream z)
; sum => 362
; seq(z) => (1 8 11 15 167 173 180 188 197 207 218 230 243 257 272
;              288 305 323 342 362)
; z => (15 180 230 305)
; y => (6 24 30 54 64 100 114 162 (stream-filter even? seq(y):18))
; 打印信息为:
; 15 
; 180 
; 230 
; 305