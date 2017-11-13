#lang scheme

(require r5rs 
         "./connector.rkt"
         "./probe.rkt")

(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0: SQUARER" (get-value b))
            (set-value! a (sqrt (get-value b)) me))
        (if (has-value? a)
            (set-value! b (sqrt (get-value a)) me))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me))
  (define (me request)
    (cond ((eq? request 'I-have-a-value) (process-new-value))
          ((eq? request 'I-lost-my-value) (process-forget-value))
          (else (error "Unknown request: PROBE" request))))
  (connect a me)
  (connect b me)
  me)

; test
(define A (make-connector))
(define B (make-connector))
(squarer A B)
(probe "A" A)
(probe "B" B)

; a -> b, ok
(set-value! A 5 'user)

; b -> a, ok
(forget-value! A 'user)
(set-value! B 16 'user)