#lang scheme

(define (make-monitored f)
  (let ((count 0))
    (lambda (action)
      (cond ((eq? action 'how-many-calls?) count)
            ((eq? action 'reset-count) (set! count 0))
            (else (begin
                    (set! count (+ count 1))
                    (f action)))))))
; test
(define (squrt x) (* x x))
(define mf (make-monitored squrt))
(mf 5)
(mf 'how-many-calls?)
(mf 2)
(mf 'how-many-calls?)
(mf 'reset-count)
(mf 3)
(mf 'how-many-calls?)