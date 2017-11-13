#lang scheme

(require (file "../3.5.1/stream.rkt"))

(provide weighted-pairs)

; merge-weight 和 merge 不同的地方是不能抛弃相等weight的项，
; 如果抛弃的话，weighted-pairs 将会丢失很多项
(define (merge-weight s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((w1 (weight (stream-car s1)))
               (w2 (weight (stream-car s2))))
           (if (or (< w1 w2) (= w1 w2))
               (cons-stream (stream-car s1)
                            (merge-weight (stream-cdr s1) s2 weight))
               (cons-stream (stream-car s2)
                            (merge-weight s1 (stream-cdr s2) weight)))))))
(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weight
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
    weight)))

; a)
(define p1 (weighted-pairs integers
                           integers
                           (lambda (lst) (apply + lst))))
(display-stream-top p1 10)

; b)
(define (divide? x d)
  (= (remainder x d) 0))
; 不能用3.56的方法，注意两个有差异
(define stream235
  (stream-filter
   (lambda (x)
     (or (divide? x 2)
         (divide? x 3)
         (divide? x 5)))
   integers))
(define p2
  (weighted-pairs stream235
                  stream235
                  (lambda (lst)
                    (let ((i (car lst))
                          (j (cadr lst)))
                      (+ (* 2 i)
                         (* 3 j)
                         (* 5 i j))))))
(display-stream-top p2 10)