#lang scheme

(define rand 
  (let ((x 20))
    (lambda (m)
      (cond ((eq? m 'generate) 
	     (begin 
	       (set! x (rand-update x))
	       x))
	    ((eq? m 'reset)
	     (lambda (val) (set! x val)))
	    (else (error "Unknown operator!" m))))))

; test 
; 模拟 rand-update
(define (rand-update x) (+ x 3))
(rand 'generate)
(rand 'generate)
((rand 'reset) 20)
(rand 'generate)
(rand 'generate)
