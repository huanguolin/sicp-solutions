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

; 要求的函数
(define (ordered-triples-sum n s) 
  (filter (lambda (list) (= (accumulate + 0 list) s)) 
          (flatmap 
           (lambda (i) 
             (flatmap (lambda (j) 
                        (map (lambda (k) (list i j k)) 
                             (enumerate-interval 1 (- j 1)))) 
                      (enumerate-interval 1 (- i 1)))) 
           (enumerate-interval 1 n)))) 
; test
(ordered-triples-sum 18 9)