#lang scheme
(define (make-rat a b)
  (let ((g (gcd a b))
        (s (if (> (* a b) 0)
               1
               -1)))
    (cons (* s (abs (/ a g)))
          (abs (/ b g)))))
; test
(make-rat -1 2) ; (-1 . 2)
(make-rat 1 -2) ; (-1 . 2)
(make-rat -2 4) ; (-1 . 2)
(make-rat -2 -4) ; (1 . 2)
(make-rat 2 4) ; (1 . 2)
(make-rat 0 -9) ; (0 . 1)