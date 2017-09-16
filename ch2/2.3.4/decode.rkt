#lang scheme

(provide decode)

(require "leaf.rkt"
	 "tree.rkt")

; decode
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      	'()
      	(let ((next-branch
	      	(choose-branch (car bits) current-branch)))
	  (if (leaf? next-branch)
	      (cons (symbol-leaf next-branch)  
		    (decode-1 (cdr bits) tree))
	      (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
	((= bit 1) (right-branch branch))
	(else (error "bad bit: CHOOSE-BRANCH" bit))))
