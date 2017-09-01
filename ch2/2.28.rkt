#lang scheme
(define (fringe list)
  (define (iter input output)
    (if (null? input)
        output
        (let ((left (car input))
              (right (cdr input)))          
          (iter right 
                (if (pair? left)
                    (iter left output)
                    (cons left output))))))
  (reverse (iter list null)))
; test
(define x (list (list 1 2) (list 3 4)))
(fringe x)
(fringe (list x x))