#lang scheme

(require (file "../3.5.1/stream.rkt"))

; require
(define (ln2-summands n)
  (stream-cons (/ 1.0 n) 
               (stream-map - (ln2-summands (+ n 1)))))
(define ln2-stream
  (partial-sums (ln2-summands 1)))
; 无法验证 ╥_╥...

; pre-define
(define (partial-sums s) 
   (add-streams s (stream-cons 0 (partial-sums s))))
(define (add-streams s1 s2)
  (stream-high-map + s1 s2))

