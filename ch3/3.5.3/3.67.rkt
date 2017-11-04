#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define
(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (stream-cons (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

; require
(define (pairs s t)
  (interleave
   (pairs-up s t)
   (pairs-down s t)))
(define (pairs-up s t)
  (stream-cons
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs-up (stream-cdr s) (stream-cdr t)))))
(define (pairs-down s t)
  (interleave
   (stream-map (lambda (x) (list x (stream-car t)))
               (stream-cdr s))
   (pairs-down (stream-cdr (stream-cdr s))
               (stream-cdr t))))

