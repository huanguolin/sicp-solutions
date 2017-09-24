#lang scheme

(define (=zero? a) (apply-generic 'zero? a))

(define (install-scheme-number-package)
  (put '=zero? 
       '(scheme-number) 
       (lambda (x) (eq? x 0))))

(define (install-rational-package)
  (put '=zero? 
       '(rationcal)
       (lambda (x) (and (eq? (numer x) 0)
			(eq? (denom x) 0)))))

(define (install-complex-package)
  (put '=zero?
       '(complex)
       (lambda (x) (and (eq? (real-part x) 0)
			(eq? (imag-part x) 0)))))

