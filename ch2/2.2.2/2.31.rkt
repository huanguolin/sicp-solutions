#lang scheme
; tools procedure
(define (square x) (* x x))

; 抽象出 tree-map
(define (tree-map f tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map f sub-tree)
             (f sub-tree)))
       tree))
; test
(define (square-tree tree) (tree-map square tree))
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7))) ; (1 (4 (9 16) 25) (36 49))