#lang scheme
(define (double f) (lambda (x) (f (f x))))

(define (inc x) (+ x 1))
(((double (double double)) inc) 5) ; 21
; (double double) ->
; (define tmp1 (lambda (x) (double (double x))))
;
; (double (double double)) ->
; (double tmp1) ->
; (define tmp2 (lambda (x) (tmp1 (tmp1 x))))
;
; ((double (double double)) inc)  ->
; (tmp2 inc) ->
; (tmp1 (tmp1 inc)) ->
; (tmp1 (double (double inc))) ->
; (tmp1 (double (lambda (x) (inc (inc x))))) ->
; (tmp1 (lambda (x) (inc (inc (inc (inc x)))))) ->
; 重命名 (define tmp3 (lambda (x) (inc (inc (inc (inc x)))))) ->
; (tmp1 tmp3) ->
; (double (double tmp3)) ->
; ...
; (inc ... (inc (inc (inc x)))) ; 共16个 inc
;
; (((double (double double)) inc) 5) ->
; 16 + 5 = 21


