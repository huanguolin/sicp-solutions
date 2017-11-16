#lang racket

(require "./sicp-content/sicp_content.rkt")
(require "./util.rkt")

(define (proc-content element pre-sn index)
  (define (print sn title)
    (let ((sn-str (string-join sn ".")))
      (display (make-string (+ 1 (length sn)) #\#))
      (display " ")
      (display sn-str)
      (display " ")
      (display title)
      (newline)))
  (let ((sn (append pre-sn (list (number->string index)))))
    (cond ((pair? element)
           (print sn (car element))
           (map (lambda (x y)
                  (proc-content x sn y))
                (cdr element)
                (enumerate-integers 1 (length (cdr element)))))
          (else
           (print sn element)))))
; test
(proc-content (cadr sicp-content) '() 2)

(define (list-exercises path)
  (define (path-proc x)
    (string-join
     (drop-right
      (string-split
       (path->string x) ".") 1) "."))
  (map path-proc
       (directory-list path)))
; test
;(list-exercises (string->path "../exercises/ch1/1.3.1"))

(define (list-dirs path)
  (filter directory-exists?
          (directory-list path
                          #:build? #t)))
; test
;(list-dirs (string->path "../exercises/ch1/"))

