#lang scheme
; 工具函数
(define (square x) (* x x))
(define (divides? d x) (= (remainder x d) 0))
(define (get-cur-ms) (current-inexact-milliseconds))

; 按题目要求增加 fast-expt
(define (fast-expt b n) 
  (define (iter b n product)
    (cond ((= n 0) product)
          ((even? n) (iter (square b) 
                           (/ n 2)
                           product))
          (else (iter b
                      (- n 1)
                      (* product b)))))
  (iter b n 1))
; 按题目所述修改 expmod 函数
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

; 书中的 fast-prime? 函数:
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
;; 测试:
;; (fast-prime? 199 3) => #t
;; (fast-prime? 1999 3) => #t
;; (fast-prime? 19999 3) => #f


;; 1.23中的函数
(define (next n)
  (cond ((= n 2) 3)
        ((odd? n) (+ n 2))
        (else (+ n 1))))
(define (new-find-prime start count)
  (if (= count 0)
      void
      (new-find-prime (next start)
                      (if (fast-prime? start 3)
                          (- count 1)
                          count))))

(define (test-new-find-prime repeat)
  (define (one-test start-time start-number repeat)
    (if (= repeat 0)
        (begin (display "start: ")
               (display start-number)
               (display " cost-time: ")
               (display (- (get-cur-ms) start-time))
               (display "ms")
               (newline))
        (begin (new-find-prime start-number 12)
          (one-test start-time start-number (- repeat 1)))))
  (display "---- repeat = ")
  (display repeat)
  (display " ----")
  (newline)
  (one-test (get-cur-ms) 1000 repeat)
  (one-test (get-cur-ms) 10000 repeat)
  (one-test (get-cur-ms) 100000 repeat)
  (one-test (get-cur-ms) 1000000 repeat)
  (display "finished!")
  (newline))

; 测试,直接运行看结果:
(test-new-find-prime 10)
; 发现运行很慢，测试根本无法完成。
; 细看，这其中有对一个数求1000次方或者更大的运算！！
; (fast-expt 2 100) =>
; 1267650600228229401496703205376
; 显然这个数字很大，当指数变大，这个结果将大的不可思议。
; 所以在 expmod 中直接使用 fast-expt 会导致运算非常
; 大的数字，导致运算变慢或者无法正常计算。