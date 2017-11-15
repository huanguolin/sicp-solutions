#lang racket

(define exercises-path "./exercises/ch1/1.3.1")

(path-string? exercises-path)
(directory-exists? (string->path exercises-path))
(directory-exists? (string->path "./abc"))

(define (path-proc x)
  (string-join
    (drop-right
     (string-split
      (path->string x) ".") 1) "."))

(map path-proc
 (directory-list
  (string->path exercises-path)))

;(find-files file-exists?
;            (string->path exercises-path))