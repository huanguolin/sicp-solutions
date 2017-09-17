#lang scheme

(require "make-leaf-set.rkt"
         "tree.rkt"
         "leaf.rkt"
         "decode.rkt"
         "2.68.rkt")

; pre-defined
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; solution
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
; test 
(define my-tree (generate-huffman-tree
                     '((C 1)
                       (D 1)
                       (B 2)
                       (A 4))))
(decode (encode '(A D A B B C A)
                my-tree)
        my-tree) ; result: '(A D A B B C A)

