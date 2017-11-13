#lang scheme

(require "./connector.rkt"
         "./adder.rkt"
         "./multiplier.rkt"
         "./constant.rkt"
         "./probe.rkt")

; use adder/multiplier/constant 
; define averager:
; a-[a1  ]
;   [+  s]-u-[m1  ]
; b-[a2  ]   [*  p]-c
;    [0.5]-r-[m2  ]

(define (averager a b c)  
  (let ((u (make-connector))
        (r (make-connector))
        (units '()))
  (define (me request)
    (cond ((eq? request 'I-have-a-value) (for-each inform-about-value units))
          ((eq? request 'I-lost-my-value) (for-each inform-about-no-value units))
          (else (error "Unknown request: AVERAGER" request))))    
    (set! units (cons (adder a b u) units))
    (set! units (cons (constant 0.5 r) units))
    (set! units (cons (multiplier u r c) units))
    me))

(define (for-each procedure list)
  (define (loop items)
    (cond ((null? items) 'done)
          (else (procedure (car items))
                (loop (cdr items)))))
  (loop list))

; test 
(define A (make-connector))
(define B (make-connector))
(define C (make-connector))
(averager A B C)
(probe "A" A)
(probe "B" B)
(probe "C" C)
; set C & B
(set-value! C 20 'user)
(set-value! B 10 'user)
; forget C, and set A
(forget-value! C 'user)
(set-value! A 5 'user)