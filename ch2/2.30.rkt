#lang scheme
; tools procedure
(define (square x) (* x x))

; a. not use map
(define (square-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))
; test
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7))) ; (1 (4 (9 16) 25) (36 49))

; b. use map
(define (square-tree-m tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-m sub-tree)
             (square sub-tree)))
       tree))
; test
(square-tree-m
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7))) ; same as above