#lang scheme

; pre-defined
(define (tree->list-1 tree)
  (if (null? tree)
    '()
    (append (tree->list-1 (left-branch tree))
	    (cons (entry tree)
		  (tree->list-1 (right-branch tree))))))
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
      result-list
      (copy-to-list (left-branch tree)
		    (cons (entry tree)
			  (copy-to-list (right-branch tree)
					result-list)))))
  (copy-to-list tree '()))

; ------------
; answer a:
; ------------
; 两者结果相同，属于左序遍历

; ------------
; answer b:
; ------------
; 第一个的复杂度是(其中O(n/2)是append的复杂度)：
; T(n) = 2T(n/2)+O(n/2) 
; 令 O(n/2) => n/2, 则有
; T(n) = 2T(n/2)+n/2 =>
; T(n) = 2(2T(n/4)+n/4)+n/2 = 4T(n/4)+2(n/2) =>
; T(n) = 4(2T(n/8)+n/8)+n = 8T(n/8)+3(n/2) =>
; ...
; T(n) = nT(1)+log2(n/2)(n/2) = n+(n/2)*log2(n/2) =>
; T(n) ~= (n/2)*log2(n) ~= n*log2(n) =>
; T(n) ~= O(n*logn)
; 
; 第二个的复杂度是:
; T(n) = 2T(n/2)+O(1)
; 令 O(1) => 1,则有
; T(n) = 2T(n/2)+1 =>
; T(n) = 2(2T(n/4)+1)+1 = 4T(n/4)+3 =>
; T(n) = 4(2T(n/8)+1)+3 = 8T(n/8)+7 =>
; ...
; T(n) = nT(1)+(n-1) = 2n-1 = 2n =>
; T(n) ~= O(n)
;
; 所以第一个需要的步骤要多一些。第二个增长慢！
;
