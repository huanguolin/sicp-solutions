#lang scheme
; set-cdr! required
(require r5rs)

(define (count-pair x)
  (define (in-list? a l)
    (if (pair? l)
        (or (eq? a (car l))
            (in-list? a (cdr l)))
        (eq? a l)))
  (let ((record null))
    (define (iter y)
      (if (or (not (pair? y)) 
              (in-list? y record))
          0
          (begin
            (set! record (cons y record))
            (+ (iter (car y))
               (iter (cdr y))
               1))))
    (iter x)))

; ======== test =========

; case 1
; [1]->[2]->[3]
(count-pair (list 1 2 3)) ; 3

; case 2
; [2]->[ ]->[1]
;       |____↑
(define a (cons 1 null)) ; 1
(define b (cons a a)) ; 1
(define c (cons 2 b)) ; 1
(count-pair c)

; case 3
; [ ]->[1]->[2]
;  |____↑
(define d (list 1 2)) ; 2
(define e (cons d d)) ; 1
(count-pair e)

; case 4
;       |――――↓
; [ ]->[ ]->[1]
;  |____↑
(define f (cons b b)) ; 1 (and a is 1, b is 1)
(count-pair f)

; loop
; [1]->[2]
;  ↑    |
;  ―[3]<-
(define t1 (cons 3 null))
(define t2 (cons 2 t1))
(define t3 (cons 1 t2))
(set-cdr! t1 t3)
(define loop t3)
(count-pair loop)