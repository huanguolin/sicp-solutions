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
; sum = 1 + 2 + 3 => 6
; seq => (1 3 6 (stream-map accum (stream-enumerate-interval 4 20)))
; y => ((stream-filter even? (2 (stream-map accum (stream-enumerate-interval 3 20)))

(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq))
; sum => 3
; seq => (1 2 (stream-map accum (stream-enumerate-interval 3 20)))

(stream-ref y 7)
(display-stream z)