#lang scheme
; 预定义函数
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))
(define (fold-right op initial sequence)
  (accumulate op initial sequence))
; compare
(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list null (list 1 2 3))
(fold-left list null (list 1 2 3))

(fold-right * 1 (list 1 2 3))
(fold-left * 1 (list 1 2 3))
(fold-right + 1 (list 1 2 3))
(fold-left + 1 (list 1 2 3))
; 由以上可以看出，op 满足交换律的时候，fold-right
; 和 fold-left可以得到相同的答案。