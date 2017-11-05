#lang scheme

(require (file "../3.5.1/stream.rkt"))

; 1) 证明略

; 2) RLC 如下

; pre-define
(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream
     initial-value
     (let ((integrand (force delayed-integrand)))
       (add-streams (scale-stream integrand dt) int))))
  int)

; require
(define (RLC r l c dt)
  (lambda (vc0 il0)
    (define vc (integral (delay dvc) vc0 dt))
    (define il (integral (delay dil) il0 dt))
    (define dvc (scale-stream il (/ (- 1) c)))
    (define dil (add-streams (scale-stream vc (/ 1 l))
                             (scale-stream il (/ (- r) l))))
    (stream-map cons vc il)))

; test
(define rlc (RLC 1 1 0.2 0.1))
(define rlc-10-0 (rlc 10 0))
(display-stream-top rlc-10-0 10)
