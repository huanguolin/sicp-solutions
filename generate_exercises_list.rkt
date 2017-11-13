#lang racket

(define exercises-path "./exercises")

(path-string? exercises-path)
(directory-exists? (string->path exercises-path))
(directory-exists? (string->path "./abc"))

(directory-list (string->path exercises-path))

(find-files (lambda (x) x)
            (string->path exercises-path))