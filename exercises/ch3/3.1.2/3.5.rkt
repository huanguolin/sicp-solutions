#lang scheme

; pre-defined
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else 
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

; required
(define (estimate-integral P x1 x2 y1 y2 trials) 
  (define (experiment) 
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (monte-carlo trials experiment))

; test
(define (square x) (* x x))
(define (P x y) 
  (let ((a (- x 5))
	(b (- y 7)))
    (<= (+ (square a) (square b)) 
	(square 3))))
; (2,4)-(8,10)
; pi * r^2 = S, r = 3
(define (estimate-pi trials) 
  (define (estimate-s times) 
    (* (* 6 6) 
       (estimate-integral P 2 8 4 10 times)))
  (/ (estimate-s trials) (square 3.0)))
(display "estinate-pi(10000x): ")
(display (estimate-pi 10000))

