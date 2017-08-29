#lang scheme
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
; test
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))
(define start (make-point 0 0))
(define end (make-point 2 1))
(define line (make-segment start end))
(define midpoint (midpoint-segment line))
(print-point midpoint) ; (1,1/2)

