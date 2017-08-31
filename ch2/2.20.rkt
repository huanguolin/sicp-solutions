#lang scheme
(define (same-parity . args)
  (define (helper f l)
    (if (null? l)
        null
        (let ((head (car l))
              (rest (cdr l)))
          (if (f head)
              (cons head (helper f rest))
              (helper f rest)))))
  (if (null? args)
      null
      (helper (if (even? (car args))
                  even?
                  odd?)
              args)))
; test
(same-parity 2 3 4 5 6 7)
(same-parity 1 2 3 4 5 6 7)