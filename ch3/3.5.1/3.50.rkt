#lang scheme

(require "./stream.rkt")

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (stream-cons
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

; test
(define int-stream-1-10 (stream-enumerate-interval 1 10))
(define int-stream-2-20 (stream-map + int-stream-1-10 int-stream-1-10))
(display-stream int-stream-2-20)
