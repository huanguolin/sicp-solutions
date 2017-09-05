#lang scheme
; 预定义函数
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

; 完善
(define (matrix-*-vector m v)
  (map (lambda (w) (dot-product w v)) m))
;test
(matrix-*-vector (list (list 1 2)
                       (list 4 5))
                 (list 1 2))
(define (transpose mat)
  (accumulate-n cons null mat))
;test
(transpose (list (list 1 2 3)
                 (list 4 5 6)
                 (list 7 8 9)))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) 
           (matrix-*-vector cols x))
         m)))
;test
(matrix-*-matrix (list (list 1 2 3)
                       (list 4 5 6))
                 (list (list 1 4)
                       (list 2 5)
                       (list 3 6)))