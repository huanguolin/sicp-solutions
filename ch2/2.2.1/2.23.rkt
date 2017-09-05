#lang scheme
(define (for-each f items)
  (cond ((not (null? items)) (f (car items))
                             (for-each f
                                       (cdr items)))))
; test
(for-each (lambda (x)
            (display x)
            (newline))
          (list 57 321 88))