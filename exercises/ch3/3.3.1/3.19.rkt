#lang scheme
; set-cdr! required
(require r5rs)

; 算法参考：
; http://blog.csdn.net/tyler_download/article/details/53691695
(define (cycle? x)
  (define (one-step lst)
    (if (pair? lst)
        (cdr lst)
        false))
  (define (two-step lst)
    (if (pair? lst)
        (one-step (cdr lst))
        false))
  (define (iter a b)
    (let ((one (one-step a))
          (two (two-step b)))
      (if (and one two)
          (or (eq? one two) (iter one two))
          false)))
  (iter x x))

; test

; case 1
; loop
; [1]->[2]
;  ↑    |
;  ―[3]<-
(define t (list 1 2 3))
(set-cdr! (cddr t) t)
(cycle? t)

; case 2
(cycle? (list 1 2 3))