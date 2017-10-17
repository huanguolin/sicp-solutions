#lang scheme

; 1, Use and-gate and inverter make or-gate
; A || B = !(!A && !B)
; (or A B) => 
; (not (and (not A) 
;           (not B)))
(define (or-gate a1 a2 output)
  (let ((b1 (make-wire))
        (b2 (make-wire))
        (s (make-wire)))
    (inverter a1 b1)
    (inverter a2 b2)
    (and-gate b1 b2 s)
    (inverter s output)))

; 2, Use and-gate-delay and inverter-delay  
;    compute or-gate-delay
(define or-gate-delay (+ (* 2 inverter-delay)
                         and-gate-delay))