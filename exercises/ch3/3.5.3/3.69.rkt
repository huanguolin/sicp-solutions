#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define
(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

;require
(define (triples s t u)
  (cons-stream
   (list (stream-car s) (stream-car t) (stream-car u))
   (interleave
    (stream-map 
     (lambda (x) (cons (stream-car s) x))
     (pairs t (stream-cdr u)))
    (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))
; test
(define p (triples integers integers integers))
(display-stream-top p 25)

; require
(define (square x) (* x x))
(define triangles
  (stream-filter
    (lambda (triple) (= (+ (square (car triple))
                           (square (cadr triple)))
                        (square (caddr triple))))
    p))
; test
(display-stream-top triangles 10) ; 算出来6个后，就内存耗尽了，看来消耗很大