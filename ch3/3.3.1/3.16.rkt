#lang scheme
; Ben's method:
(define (count-pair x)
  (if (not (pair? x))
      0
      (+ (count-pair (car x))
         (count-pair (cdr x))
         1)))

; test case
; output 3
; [1]->[2]->[3]
(count-pair (list 1 2 3)) ; 3

; output 4
; [2]->[ ]->[1]
;       |____↑
(define a (cons 1 null)) ; 1
(define b (cons a a)) ; 1
(define c (cons 2 b)) ; 1
(count-pair c)

; output 5
; [ ]->[1]->[2]
;  |____↑
(define d (list 1 2)) ; 2
(define e (cons d d)) ; 1
(count-pair e)

; output 7
;       |――――↓
; [ ]->[ ]->[1]
;  |____↑
(define f (cons b b)) ; 1 (and a is 1, b is 1)
(count-pair f)

; loop
; [1]->[2]
;  ↑    |
;  ―[3]<-
