#lang scheme
; from 2.18
(define (reverse list)
  (define (iter input output)
    (if (null? input)
        output
        (iter (cdr input) 
              (cons (car input)
                    output))))
  (iter list null))

; deep-reverse
(define (deep-reverse list)
  (define (iter input output)
    (if (null? input)
        output
        (let ((left (car input))
              (right (cdr input)))
          (iter right 
                (cons (if (pair? left)
                          (iter left null)
                          left)
                      output)))))
  (iter list null))
; test
(define x (list (list 1 2) (list 3 4)))
x ; ((1 2) (3 4))
(reverse x) ; ((3 4) (1 2))
(deep-reverse x) ; ((4 3) (2 1))