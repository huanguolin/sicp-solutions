#lang scheme

(provide generate-huffman-tree)

(require "make-leaf-set.rkt"
         "tree.rkt"
         "leaf.rkt")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
(define (successive-merge tree-set)
  (define (insert e l)
    (if (null? l) 
        (list e)
        (let ((e-1(car l))
              (rest (cdr l)))
          (if (<= (weight e) (weight e-1))
              (cons e l)
              (cons (car l) (insert e rest))))))
  (let ((first (car tree-set))
        (rest (cdr tree-set)))
    (if (null? rest)
        first 
        (successive-merge (insert (make-code-tree first
                                                  (car rest))
                                  (cdr rest))))))
