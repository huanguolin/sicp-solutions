#lang scheme
; tools
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num) (and (number? exp) (= exp num)))

;================ b =================
; 我的思路是把这种表达式转化为 a 中的表达式,
; 然后用 a 中的函数继续处理即可.
; add new transfer procedure
(define (transfer exp)
  (define (high-op? op) (same-variable? op '*))
  (if (or (not (pair? exp))
          (< (length exp) 5))
      exp
      (let ((first-op (cadr exp))
            (second-op (cadddr exp)))
        (let ((first-high (high-op? first-op))
              (second-high (high-op? second-op)))
          (cond ((or first-high
                     (not second-high))
                 (transfer (cons (list (transfer (car exp))
                                       (cadr exp)
                                       (transfer (caddr exp)))
                                 (cdddr exp))))
                (else
                 (transfer (list (transfer (car exp))
                                 (cadr exp)
                                 (transfer (cddr exp))))))))))
;test
(display "测试 transfer :")
(newline)
(transfer '(3 * 4 + 5)) ;((3 * 4) + 5)
(transfer '(3 + 4 * 5)) ;(3 + (4 * 5))
(transfer '(3 + 4 + 5)) ;(3 + (4 * 5))
(transfer '(3 * 4 * 5)) ;((3 * 4) * 5))
(transfer '(3 + 4 + 5 * 6)) ;((3 + 4) + (5 * 6))
(newline)

; sum part
(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
(define (addend s) (car s))
(define (augend s) (caddr s))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list a1 '+ a2))))
; multiple part
(define (product? x) (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))
(define (multiplicand p) (caddr p))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))
; 旧微分函数
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type: DERIV" exp))))

; 新微分函数
(define (new-deriv exp var)
  (deriv (transfer exp) var))
; test
(display "测试 new-deriv :")
(newline)
(new-deriv '(x + 3 * (x + y + 2)) 'x)
(new-deriv '(x * (y + 2)) 'x)




