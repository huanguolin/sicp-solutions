#lang scheme

(define (make-from-mag-ang magnitude angle)
  (define (dispatch op)
    (cond ((eq? op 'magnitude) magnitude)
	  ((eq? op 'angle) angle)
	  ((eq? op 'real-part) (* magnitude (cos angle)))
	  ((eq? op 'imag-part) (* magnitude (sin angle)))
	  (else (error "Unknown op -- MAKE-FROM-MAG-ANG" op))))
  dispatch)

