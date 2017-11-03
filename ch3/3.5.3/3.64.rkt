#lang scheme

(require (file "../3.5.1/stream.rkt"))

(define (stream-limit s tolerance)
  (let ((v1 (stream-car s))
        (v2 (stream-car (stream-cdr s))))
    (if (< (abs (- v1 v2)) tolerance)
        v2
        (stream-limit (stream-cdr s) tolerance))))

; 无法测试 ╥_╥...