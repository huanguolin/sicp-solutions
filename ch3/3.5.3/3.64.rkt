#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define 
(define (average a b) (/ (+ a b) 2))
(define (sqrt-improve guess x)
  (average guess (/ x guess)))
(define (sqrt-stream x)
  (define guesses
    (cons-stream
     1.0
     (stream-map
      (lambda (guess) (sqrt-improve guess x))
      guesses)))  
  guesses)

; require
(define (stream-limit s tolerance)
  (let ((v1 (stream-car s))
        (v2 (stream-car (stream-cdr s))))
    (if (< (abs (- v1 v2)) tolerance)
        v2
        (stream-limit (stream-cdr s) tolerance))))

; test
(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
(sqrt 2 0.00001)
(sqrt 3 0.00001)