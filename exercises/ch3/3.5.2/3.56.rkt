#lang scheme

(require (file "../3.5.1/stream.rkt"))

; pre-define 
(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream
                   s2car
                   (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1)
                          (stream-cdr s2)))))))))
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
              stream))

; require
(define S
  (cons-stream 1 (merge (merge (scale-stream S 2)
                               (scale-stream S 3))
                        (scale-stream S 5))))

; test
(cond-display-stream S (lambda (x) (< x 50)))