#lang scheme
 ;; 工具函数
(define (square x) (* x x))
(define (divides? d x) (= (remainder x d) 0))
(define (get-cur-ms) (current-inexact-milliseconds))

;; 题目中要求的 next 函数
;; 我针对 find-prime 函数做了优化
(define (next n)
  (cond ((= n 2) 3)
        ((odd? n) (+ n 2))
        (else (+ n 1))))

;; 改进书中的 prime? 函数:
(define (prime? n)
  (= n (smallest-divisor n)))
(define (smallest-divisor n) 
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (find-divisor n 2))
;; 测试:
;; (prime? 199) => #t
;; (prime? 1999) => #t
;; (prime? 19999) => #f

;; 1.22的 timed-prime-test 函数:
(define (timed-prime-test n)
  (define (start-test n start-time)
    (if (prime? n) 
        (report n (- (get-cur-ms) start-time))
        #f))
  (define (report n cost-time)
    (display n)
    (display " [ms: ")
    (display cost-time)    
    (display "]")    
    (newline))
  (start-test n (get-cur-ms)))

;; 改进1.22的找质数程序
(define (find-prime start count)
  (if (= count 0)
      (display "finished!")
      (find-prime (next start)
                  (if (timed-prime-test start)
                      (- count 1)
                      count))))

;; 比以前更快了,所以更看不到时间消耗了.
;; 所以我决定使用循环来看总时间的消耗:
(define (new-find-prime start count)
  (if (= count 0)
      void
      (new-find-prime (next start)
                      (if (prime? start)
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
        (begin (new-find-prime start-number 3)
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
;; 取重复次数最多的,如下可以看出基本呈
;; √10 ≌ 3.16 递增
;; ---- repeat = 100000 ----
;; start: 1000 cost-time: 1029.601806640625ms
;; start: 10000 cost-time: 3713.806640625ms
;; start: 100000 cost-time: 9142.6162109375ms
;; start: 1000000 cost-time: 20339.83642578125ms
;; finished!