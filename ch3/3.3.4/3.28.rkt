#lang scheme

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) 
                                 (get-signal a2))))
      (after-delay 
       or-gate-delay
       (lambda () (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

(defien (valid-signal in)
  (let ((one (= in 1))
        (zero (= in 0)))
    (if (and (not one)
             (not zero))
        (error "Invalid signal" in))))

(define (logical-or a1 a2)
  (valid-signal a1)
  (valid-signal a2)
  (if (= 0 (+ a1 a2)) 
      0
      1))