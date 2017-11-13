#lang scheme

; pre-defined
(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire)) (c1 (make-wire)) (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

; require
(define (ripple-carry-adder)
  (define (iter A B c-in S c-out)
    (let ((c-temp (make-wire))
          (An (car A))
          (Bn (car B))
          (Sn (car S)))
      (cond ((null? (cdr A))
             (full-adder An Bn c-in Sn c-out)
             'ok)
            (else 
             (full-adder An Bn c-in Sn c-temp)
             (iter (cdr A) (cdr B) c-temp (cdr S) c-out))))))

; how to compute n-bit ripple-carry adder delay 
; use and-gates, or-gates, and inverters?

; or-gate-delay, from 3.29
(define or-gate-delay (+ (* 2 inverter-delay)
                         and-gate-delay))

; half-adder-delay
(define half-adder-delay (+ or-gate-delay and-gate-delay))

; full-adder-delay
(define full-adder-delay (+ (* 2 half-adder-delay)
                            or-gate-delay))

; ripple-carry-adder-delay
(define (ripple-carry-adder-delay n)
  (* n full-adder-delay))

