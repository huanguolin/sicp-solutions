#lang scheme
(require (planet "sicp.ss"
                 ("soegaard"
                  "sicp.plt" 2 1)))
; 补充定义函数
(define (split t1 t2)
  (define (helper painter n)
    (if (= n 0)
        painter
        (let ((smaller (helper painter (- n 1))))
          (t1 painter (t2 smaller smaller)))))
  helper)

; 预定义函数
(define right-split (split beside below))
(define up-split (split below beside))

;test
(paint (right-split einstein 2))
(paint (up-split einstein 2))