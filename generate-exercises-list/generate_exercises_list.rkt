#lang racket

(define (list-exercises path)
  (define (path-proc x)
    (string-join
     (drop-right
      (string-split
       (path->string x) ".") 1) "."))
  (map path-proc
       (directory-list path)))
; test
(list-exercises (string->path "../exercises/ch1/1.3.1"))

(define (list-dirs path)
  (filter directory-exists?
          (directory-list path
                          #:build? #t)))
; test
(list-dirs (string->path "../exercises/ch1/"))

