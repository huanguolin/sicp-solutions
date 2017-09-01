#lang scheme
; 预定义函数
(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

; a. 实现 left and right branch selector
;    还有 branch-length and branch-structure
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

; b. 实现 total-weight
(define (total-weight mobile)
  (define (branch-weight branch)
    (let ((struct (branch-structure branch)))
      (if (pair? struct)
          (total-weight struct)
          struct)))
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))
; test
(define b1 (make-branch 1 6))
(define b2 (make-branch 2 3))
(define m1 (make-mobile b1 b2))
(define b3 (make-branch 3 m1))
(define m2 (make-mobile b2 b3))
(total-weight m1) ; 9
(total-weight m2) ; 12

; c. 实现 balanced?
(define (balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (let ((ls (branch-structure left))
          (rs (branch-structure right))
          (ll (branch-length left))
          (rl (branch-length right))) 
      (let ((is-l-mobile (pair? ls))
            (is-r-mobile (pair? rs)))
        (cond ((and is-l-mobile
                    is-r-mobile) (and (balanced? ls)
                                      (balanced? rs)))
              ((and (not is-l-mobile)
                    (not is-r-mobile)) (= (* ll ls)
                                          (* rl rs)))
              (else false))))))
; test
(balanced? m1) ; #t
(balanced? m2) ; #f

; d. 如果修改预定义函数，其他函数该如何修改？
;(define (make-mobile left right) (cons left right))
;(define (make-branch length structure)
;  (cons length structure))
;
; 答: 只需要 branch-structure 和 right-branch 如下:
;(define (right-branch mobile)
;  (cdr mobile))
;(define (branch-structure branch)
;  (cdr branch))