#lang scheme
 ;; 工具函数
(define (square x) (* x x))
(define (divides? d x) (= (remainder x d) 0))
(define (get-cur-ms) (current-inexact-milliseconds))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

;; 书中的 fast-prime? 函数:
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


;; 题目中要求用1.22中的函数测试,
;; 我这里选用1.23中自己写的函数来试验
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

;; 测试,直接运行看结果:
(test-new-find-prime 10)
(test-new-find-prime 100)
(test-new-find-prime 1000)
(test-new-find-prime 10000)
(test-new-find-prime 100000)
;; 可以看出增长呈减弱的趋势