#lang scheme

(provide sample-tree)

(require "decode.rkt"
	 "tree.rkt"
	 "leaf.rkt")

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
		  (make-code-tree
		    (make-leaf 'B 2)
		    (make-code-tree
		      (make-leaf 'D 1)
		      (make-leaf 'C 1)))))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
; result: (A D A B B C A)
(decode sample-message sample-tree)

