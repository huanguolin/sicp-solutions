#lang scheme

(define (install-raise-package)
  ; inner procedure
  (define (integer->rational x)
    (make-rational x 1))
  (define (rational->real x)
    (make-real (/ (numer x) (denom x))))
  (define (real->complex x)
    (make-from-real-imag x 0))
  ; install
  (put 'raise 'integer integer->rational)
  (put 'raise 'rational rational->real)
  (put 'raise 'real real->complex)
  'done)

(define (raise x) (apply-generic 'raise x))
