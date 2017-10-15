#lang scheme

; set-cdr! required
(require r5rs)

(define (cycle? x)  
  (define record null)
  (define (iter y)
    (if (pair? y)
        (if (memq y record)
            true
            (begin (set! record (cons y record))
                   (iter (cdr y))))
        false))
  (iter x))

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