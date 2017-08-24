#lang scheme
;; 工具函数
(define (square x) (* x x))
(define (divides? d x) (= (remainder x d) 0))
(define (get-cur-ms) (current-inexact-milliseconds))

;; 书中正文预定义函数
(define (prime? n)
  (= n (smallest-divisor n)))
(define (smallest-divisor n) 
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n 
                              (+ test-divisor 1)))))
  (find-divisor n 2))

;; 修改了题目中预定义函数,
;; 让它仅仅在测到质数时才有输出,
;; 并且整个函数会在:
;; 测到质数时返回 #t, 非质数返回 #f
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

;; 题目要求的找质数程序
(define (find-prime start count)
  (if (= count 0)
      (display "finished!")
      (if (odd? start)
          (find-prime (+ start 2)
                      (if (timed-prime-test start)
                          (- count 1)
                          count))
          (find-prime (+ start 1)
                      count))))

;; 题目要求的求值:
;;
;; 3个大于1,000的质数:
;; (find-prime 1000 3)
;; 1009 [ms: 0.0]
;; 1013 [ms: 0.0]
;; 1019 [ms: 0.0]
;; finished!
;;
;; 3个大于10,000的质数:
;;(find-prime 10000 3)
;; 10007 [ms: 0.0]
;; 10009 [ms: 0.0]
;; 10037 [ms: 0.0]
;; finished!
;;
;; 3个大于100,000的质数:
;; 100003 [ms: 0.0]
;; 100019 [ms: 0.0]
;; 100043 [ms: 0.0]
;; finished!
;;
;; 3个大于1,000,000的质数:
;; (find-prime 1000000 3)
;; 1000003 [ms: 0.0]
;; 1000033 [ms: 0.0]
;; 1000037 [ms: 0.0]
;; finished!

;; 根据以上的结果无法看出有Θ(√n)的增长。
;; 以上的计算耗时均为0ms, 可能是电脑性能
;; 比较好导致的。
;; 
;; 现在将数值提高可以得到有耗时的情况:
;;(find-prime 1000000000 3)
;; 1000000007 [ms: 15.60009765625]
;; 1000000009 [ms: 0.0]
;; 1000000021 [ms: 0.0]
;; finished!
;; 而且耗时不稳定:
;; (find-prime 1000000000 3)
;; 1000000007 [ms: 0.0]
;; 1000000009 [ms: 15.60009765625]
;; 1000000021 [ms: 0.0]
;; finished!
;; 由此可见，与进程的调度或当前系统的繁忙
;; 情况有关。所以这里的测试结果无法证明
;; 复杂度为Θ(√n)的推论。原因是这里的测试
;; 环境不够纯。