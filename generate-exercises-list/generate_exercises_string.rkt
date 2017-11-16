#lang racket

(require "./util.rkt")

(provide generate-exercises-string)

; functions
(define (generate-exercises-string dir-path fix-path)
  (let ([files-name (filter exercise-file-name?
                            (list-files-name dir-path))])
    (string-join
     (map (lambda (name file-name)
            (string-append "[("
                           name
                           ")]("
                           fix-path
                           "/"
                           file-name
                           ")\n"))
          (map get-exercise-name files-name)
          files-name)
     "")))

(define (exercise-file-name? name)
  (regexp-match #px"^\\d+\\.\\d+\\.rkt$" name))

(define (get-exercise-name file-name)
  (car (regexp-match #px"^\\d+\\.\\d+" file-name)))

; test
;(generate-exercises-string "../exercises/ch1/1.3.1/" "./exercises/ch1/1.3.1")
;(generate-exercises-string "./" "../")
