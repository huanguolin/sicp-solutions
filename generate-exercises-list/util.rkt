#lang racket

(provide enumerate-integers
         append-lines-to-file
         append-line-to-file
         list-files-name)

(define (enumerate-integers low high)
  (if (> low high)
      '()
      (cons low
            (enumerate-integers (+ low 1)
                                high))))

(define (append-lines-to-file line-list file-path)
  (display-lines-to-file line-list
                         file-path
                         #:mode 'text
                         #:exists 'append))

(define (append-line-to-file str file-path)
  (if (string? str)
      (append-lines-to-file (list str) file-path)
      (error "[append-line-to-file] it's not string: "
             str)))

(define (list-files-name dir-path)
  (define (my-file-exists? path)
    (file-exists?
     (string->path
      (string-append dir-path
                     "/"
                     (path->string path)))))
(let ([path (string->path dir-path)])
  (if (directory-exists? path)
      (map path->string
           (filter my-file-exists?
                   (directory-list
                    (string->path dir-path))))
      '())))
; test
; (list-files-name "../")