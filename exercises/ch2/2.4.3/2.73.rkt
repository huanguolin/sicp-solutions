#lang scheme

;----------------
; a.
;----------------
; 1）改写后对于不同的运算（如 +，*等）可以分派不同的过程方法处理，
;    而且以后有新增的运算，也不用改这个过程。
; 2) 为什么谓词 number? 和 variable? 不能用分派方法的方式？因为
;    谓词本身就是判断其“类型”的，所以无法给它再建立类型来分派方法。

;----------------
; b.
;----------------
; 1) sums
(define (install-sums-package)
  ;; internal procedures
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (make-sum a1 a2) (list '+ a1 a2))
  (define (deriv-sums args var)
    (make-sum (deriv (addend args) var)
	      (deriv (augend args) var)))
  (put 'deriv '+ deriv-sums)
  'done)
; 2) products
(define (install-products-package)
  ;; internal procedures
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  (define (make-product m1 m2) (list '* m1 m2))
  (define (deriv-products args var)
    (make-product (deriv (multiplier args) var)
	          (deriv (multiplicand args) var)))
  (put 'deriv '* deriv-product)
  'done)
 

;----------------
; c.
;----------------
; add exponents
(define (install-exponents-package)
  ;; internal procedures
  (define (base x) (cadr x))
  (define (exponent x) (caddr x))
  (define (make-exponentiation b e)
   (cond ((=number? e 0) 1)
    	 ((=number? e 1) b)
	 (else (list '** b e))))
  (define (deriv-exponents args var)
   (make-expoentiation (deriv (base args) var)
    		       (deriv (exponent args) var)))
  (put 'deriv '^ deriv-exponents)
  'done)

;----------------
; c.
;----------------
; 仅仅把 put 的前两个参数换一下位置，即可
