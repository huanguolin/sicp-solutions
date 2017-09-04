#lang scheme
; 预定义函数
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
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))
; 题目预定义
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row 
                                    k 
                                    rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; 补充定义
(define empty-board null)
(define (safe? k positions)
  (let ((k-queen (car positions)))
    (define (iter col rest)
      (if (null? rest)
          true
          (let ((queen (car rest)))
            (if (or (= k-queen queen)
                    (= col (abs (- k-queen queen))))
                false
                (iter (+ col 1) 
                      (cdr rest))))))
    (iter 1 (cdr positions))))
(define (adjoin-position new-row 
                         k 
                         rest-of-queens)
  (cons new-row rest-of-queens))


; test
(define (print-queens n)
  (display n) 
  (display " x ")
  (display n)
  (display ":")
  (newline)
  (display (queens n))
  (newline)
  (newline))
(print-queens 2)
(print-queens 3)
(print-queens 4)
(print-queens 5)
(print-queens 6)
(print-queens 7)
(print-queens 8)
