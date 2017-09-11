#lang scheme

; pre-defined
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))
(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result
	      (partial-tree elts left-size)))
	(let ((left-tree (car left-result))
	      (non-left-elts (cdr left-result))
	      (right-size (- n (+ left-size 1))))
	  (let ((this-entry (car non-left-elts))
		(right-result
		  (partial-tree
		    (cdr non-left-elts)
		    right-size)))
	    (let ((right-tree (car right-result))
		     (remaining-elts
		       (cdr right-result)))
		 (cons (make-tree this-entry
				  left-tree
				  right-tree)
		       remaining-elts))))))))
; test
(list->tree '( 1 3 5 7 9 11))

; -----------------
; a 
; -----------------
; 解释：程序每次先生成左子树，在生成entry，最后生成右子树；
;       然后左右子树再如此递归直到n为0.
; 
; (list->tree '( 1 3 5 7 9 11)) 的结果如下：
; (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))

; -----------------
; b 
; -----------------
; 复杂度分析：
; T(n)=2T(n/2)+O(1)=2T(n/2)+1 =>
; T(n)=2(2T(n/4)+1)+1=4T(n/4)+3 =>
; T(n)=2(4T(n/8)+1)+3=8T(n/8)+5 =>
; ...
; T(n)=nT(1)+(n-1)=2n-1 =>
; T(n) ~= O(n)
