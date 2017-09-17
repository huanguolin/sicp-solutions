#lang scheme

(provide encode)

(require "leaf.rkt"
         "tree.rkt"
         "2.67.rkt")

; pre-defined
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
; encode-symbol
(define (encode-symbol char tree)
  (define (correct-branch? branch)
    (list-has? char (symbols branch))) ; symbols auto detect leaf or tree
  (let ((lb (left-branch tree))
        (rb (right-branch tree)))
    (cond ((correct-branch? lb)
           (if (leaf? lb)
               '(0)
               (cons 0 (encode-symbol char lb))))
          ((correct-branch? rb)
           (if (leaf? rb)
               '(1)
               (cons 1 (encode-symbol char rb))))
          (else (error "the tree not contain this char: " char)))))
(define (list-has? e l)
  (cond ((null? l) false)
        ((equal? e (car l)) true)
        (else (list-has? e (cdr l)))))
; test
(define msg '(A D A B B C A))
(display "except: ")
(display '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(newline)
(display "result: ")
(encode msg sample-tree)
