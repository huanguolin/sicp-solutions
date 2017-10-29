#lang scheme

(require (file "../3.5.1/stream.rkt"))

(define (add-streams s1 s2)
  (stream-high-map + s1 s2))
(define (partial-sums s)
  (stream-cons (stream-car s)
               (add-streams partial-sums
                            (stream-cdr s))))
; 含有stream-high-map的递归无穷流不验证,不知为何会导致死循环