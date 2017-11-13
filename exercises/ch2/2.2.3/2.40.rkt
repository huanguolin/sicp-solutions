#lang scheme
; 预定义函数
(define (square x) (* x x))
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))
(define (enumerate-interval min max)
  (if (> min max)
      null
      (cons min
            (enumerate-interval (+ min 1)
                                max))))

; 要求的函数
(define (unique-pairs n)
  (accumulate append 
              null 
              (map (lambda (i)
                     (map (lambda (j) (list i j))
                          (enumerate-interval 1 (- i 1))))
                   (enumerate-interval 1 n))))
; test 
(display "test unique-pairs: ")
(unique-pairs 3)

(define (prime-sum-pairs n)
  (define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))
  (define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))
; test
(display "test prime-sum-pairs: ")
(prime-sum-pairs 3)