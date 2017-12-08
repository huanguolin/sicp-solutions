#lang racket

(require "./util.rkt")

(provide generate-exercises-string)

; functions
(define (generate-exercises-string dir-path fix-path)
  (define (generate-exercise-string info)
    (let ([exercise-name (car info)]
          [file-path (cdr info)])
      (string-append "[("
                     exercise-name
                     ")]("
                     fix-path
                     "/"
                     file-path
                     ")\n")))
  (let ([files-name (filter exercise-file-name?
                            (list-files-name dir-path))])
    (string-join
     (map generate-exercise-string
          (sort (map cons
                     (map get-exercise-name files-name)
                     files-name)
                exercise-name-less?
                #:key car))
     "")))

(define (exercise-name-less? x y)
  (define (get-tail-number e)
    (string->number (cadr (string-split e "."))))
  (let ([a (get-tail-number x)]
        [b (get-tail-number y)])
    (< a b)))

(define (exercise-file-name? name)
  (regexp-match #px"^\\d+\\.\\d+\\.rkt$" name))

(define (get-exercise-name file-name)
  (car (regexp-match #px"^\\d+\\.\\d+" file-name)))

; test
;(generate-exercises-string "../exercises/ch2/2.1.4/" "./exercises/ch1/1.3.1")
;(generate-exercises-string "./" "../")
