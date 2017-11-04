#lang scheme

; 参考 predefined.scm 写出流的基本过程
; 地址 http://www.math.pku.edu.cn/teachers/qiuzy/progtech/predefined.scm

(require r5rs)

(provide the-empty-stream
         stream-null?
         cons-stream
         stream-car
         stream-cdr
         ; stream list operation
         stream-ref
         stream-map
         stream-for-each
         stream-filter
         scale-stream
         ; basic stream generation
         stream-enumerate-interval
         integers-starting-from
         ; display operation
         display-stream
         cond-display-stream
         display-stream-top
         ; common streams
         ones
         integers
         ; stream operator
         add-streams
         mul-streams
         partial-sums
         merge
         interleave)


; ==== basic define ====
(define-syntax cons-stream
  (syntax-rules ()
    ((_ A B) (cons A (delay B)))))
(define the-empty-stream '())
(define (stream-null? x) (null? x))
(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

; ==== list function ===
; ref/map/for-each/filter/scale
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
; 这个定义是下面那个定义的特例，所以下面的那个更通用。
; (define (stream-map proc s)
;  (if (stream-null? s)
;      the-empty-stream
;      (cons-stream (proc (stream-car s))
;                   (stream-map proc (stream-cdr s)))))
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))
(define (stream-for-each proc s)
  (if (stream-null? s)      
      (display-line '*done*)
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))
(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter
                       pred
                       (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))
(define (scale-stream s factor)
  (stream-map (lambda (x) (* x factor)) s))

; ==== basic stream generation ==== 
(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

; ==== stream display ====
(define (display-line x) (newline) (display x))
(define (display-stream s)
  (stream-for-each display-line s))
(define (cond-display-stream s cond)
  (if (or (stream-null? s)
          (not (cond (stream-car s))))
      (display-line '*done*)
      (begin
        (display-line (stream-car s))
        (cond-display-stream (stream-cdr s)
                             cond))))
(define (display-stream-top s n)
  (define (stop? x)
    (if (> n 0)
        (begin
          (set! n (- n 1))
          #t)
        #f))
  (cond-display-stream s stop?))

; ==== common streams ====
(define ones (cons-stream 1 ones))
(define integers (integers-starting-from 1))

; ==== stream operator ====
; add/mul/partial-sums/merge/interleave
(define (add-streams s1 s2)
  (cons-stream
   (+ (stream-car s1) (stream-car s2))
   (stream-map + (stream-cdr s1) (stream-cdr s2))))
(define (mul-streams s1 s2)
  (stream-map * s1 s2))
(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams partial-sums
                            (stream-cdr s))))
(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream
                   s2car
                   (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1)
                          (stream-cdr s2)))))))))
(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))