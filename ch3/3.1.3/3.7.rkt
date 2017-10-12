#lang scheme

; pre-defined
(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount) 
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch pw m)
    (cond ((not (eq? pw password)) (error "Incorrect password"))
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: MAKE-ACCOUNT"
                       m))))
  dispatch)

; required
(define (make-joint account password new-password)
  (define (dispatch pw m)
    (if (eq? pw new-password)
        (account password m)
        (error "Incorrect password")))
  ((account password 'deposit) 0)
  dispatch)

; test
(define peter-acc (make-account 100 '123456))
((peter-acc '123456 'withdraw) 40)
(define paul-acc (make-joint peter-acc '123456 'paul))
((paul-acc 'paul 'withdraw) 20)
((peter-acc '123456 'deposit) 0)

