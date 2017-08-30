#lang scheme
; 预定义函数
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
; one
(define one    
    (lambda (f) 
      (lambda (x) 
        (f x))))
; two
(define two    
    (lambda (f) 
      (lambda (x) 
        (f (f x)))))
; add
; 参考: http://community.schemewiki.org/?sicp-ex-2.6
(define (add a b)
  (lambda (f) 
    (lambda (x) 
      ((a f) ((b f) x)))))
; test
(define (square x) (* x x))
((one square) 2) ; 4
((two square) 2) ; 16
(((add two one) square) 2) ; 256
; 通过以上测试代码，可以看出，这里定义数字多少
; 的方式,是把它转化为操作，2就是两次操作, 
; n 就是 n 次操作。
; 对应到zero/one/two/add等定义中返回的函数，
; 它的参数是 f, 代表操作;
; 它的返回值是另外一个函数，这个函数的参数是 x,
; 代表操作对象，对应到测试代码，就是数字。
