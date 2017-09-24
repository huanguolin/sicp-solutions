#lang scheme

(define (equ? a b) (apply-generic 'equ? a b))

(define (install-scheme-number-package)
  ; ...
  (put 'equ? 
       '(scheme-number scheme-number) 
       =)
  'done)

(define (install-rational-package)
  ; ...
  (put 'equ? 
       '(rationcal rationcal)
       (lambda (x y) (= (* (numer x) (denom y))
			(* (denom x) (numer y)))))
  'done)

(define (install-complex-equ?)
  ; ...
  (put 'equ?
       '(complex complex)
       (lambda (x y) (and (= (real-part x) (real-part y))
			  (= (imag-part x) (imag-part y)))))
  'done)

