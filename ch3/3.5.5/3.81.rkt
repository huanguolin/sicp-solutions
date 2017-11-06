#lang scheme

(require (file "../3.5.1/stream.rkt"))

; 参考: https://github.com/jiacai2050/sicp/blob/master/exercises/03/3.81.scm

(define (rand-update x)
  (let ((a (expt 2 32))
        (c 1103515245)
        (m 12345))
    (modulo (+ (* a x) c) m)))

(define random-init 137)

(define (random-numbers cmd-stream)
  (define (action number cmd)
    (if (eq? cmd 'generate)
        (rand-update number)
        cmd))
  (cons-stream random-init
               (stream-map action
                           (random-numbers cmd-stream)
                           cmd-stream)))

; test
(define cmds-1
  (cons-stream 'generate 
               (cons-stream 'generate
                            (cons-stream 'generate
                                         (cons-stream 'generate '())))))
(define s1 (random-numbers cmds-1))
(display-stream-top s1 4)

; test
(define cmds-2
  (cons-stream 'generate 
               (cons-stream 137
                            (cons-stream 'generate
                                         (cons-stream 'generate '())))))
(define s2 (random-numbers cmds-2))
(display-stream-top s2 4)