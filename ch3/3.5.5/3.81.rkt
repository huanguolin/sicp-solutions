#lang scheme

(require (file "../3.5.1/stream.rkt"))

(define rand
  (define rand-nums
    (cons-stream random-init
                 (stream-map rand-update rand-sums)))
  (define (dispatch message) 
    (cond ((eq? message 'generate) 
           (stream) 
           ((eq? message 'reset) 
            (lambda (new-value) (set! x new-value))))) 
    dispatch) 