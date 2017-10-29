#lang scheme

(require (file "../3.5.1/stream.rkt"))

; mul-streams define
(define (mul-streams s1 s2)
  (stream-high-map * s1 s2))
; test
(define s (stream-enumerate-interval 1 10))
(define s*s (mul-streams s s))
(display-stream s*s)

; factorials define
(define factorials
  (stream-cons 1
               (mul-streams factorials
                            (integers-starting-from 2))))
; 含有stream-high-map的递归无穷流不验证,不知为何会导致死循环