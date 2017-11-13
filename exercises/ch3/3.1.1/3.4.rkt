#lang scheme

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount) 
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (call-the-cops val)
    (error "Call the cops, illegal operation, $: "
           val))
  (let ((err-times 0)
        (max-err-times 7))
    (lambda (pw m)
      (cond ((not (eq? pw password)) 
             (if (>= err-times max-err-times)
                 call-the-cops	 
                 (begin 
                   (set! err-times (+ err-times 1))
                   (error "Incorrect password"))))
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT"
                         m))))))

; test
(define acc (make-account 100 'secret-password))
;((acc 'some-other-password 'deposit) 50) ; 7+

