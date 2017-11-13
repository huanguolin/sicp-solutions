#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

; redefined monte-carlo from 3.5
(define (monte-carlo experiment)
  (define (one-test) (if (experiment) 1 0))
  (define (proc x) (cons (+ (car x) (one-test))
                         (+ (cdr x) 1)))
  (define monte-carlo-s
    (cons-stream (cons (one-test) 1) ; (passed . total)
                 (stream-map proc monte-carlo-s)))
  monte-carlo-s)
(define (estimate-integral P x1 x2 y1 y2) 
  (define (experiment) 
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (stream-map (lambda (x)
                (/ (car x)
                   (cdr x)))
              (monte-carlo experiment)))

; test
(define (square x) (* x x))
(define (P x y) 
  (let ((a (- x 5))
        (b (- y 7)))
    (<= (+ (square a) (square b)) 
        (square 3))))
; (2,4)-(8,10)
; pi * r^2 = S, r = 3
(define pi-stream
  (stream-map (lambda (x)
                (/ (* (square 6) x)
                   (square 3.0)))
              (estimate-integral P 2 8 4 10)))
(display "(stream-ref pi-stream 10000): ")
(display (stream-ref pi-stream 10000))
