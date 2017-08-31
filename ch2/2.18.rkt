#lang scheme
(define (reverse list)
  (define (iter old new)
    (if (null? old)
        new
        (iter (cdr old) (cons (car old) new))))
  (iter list null))
; test
(reverse (list 1 2 3 4))