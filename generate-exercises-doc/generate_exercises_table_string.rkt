#lang racket

(provide generate-exercises-table-lines)

; configure
(define exercises-root-path "../exercises")
(define exercises-fix-path "./exercises")

; dependency
(require "./sicp-content/sicp_content.rkt")
(require "./generate_exercises_string.rkt")
(require "./util.rkt")

; functions
(define (generate-exercises-table-lines)
  (define sn-tree (gen-sn-tree sicp-content '()))
  (define sn-list (gen-sn-list sn-tree))
  (define sn-string-list
    (map (lambda (x)
           (let ([sn-str (map number->string x)])
             (string-join sn-str ".")))
         sn-list))
  (define exercise-path-list
    (map (lambda (x y)
           (string-append
            exercises-root-path
            "/"
            "ch"
            (number->string (car x))
            "/"
            y))
         sn-list
         sn-string-list))
  (define exercise-string-list
    (map (lambda (x)
           (generate-exercises-string
            x
            (substring x 1)))
         exercise-path-list))
  (define table-header
    '("|Chapter|Exercises|"
      "|:-:|:-|"))
  (define table-data    
    (filter
     (lambda (x) (> (string-length x) 0))
     (map (lambda (x y)
            (if (> (string-length y) 0)
                (string-append "|"
                               x
                               "|"
                               y
                               "|")
                ""))
          sn-string-list
          exercise-string-list)))
  (append table-header table-data))

(define (gen-sn-list sn-tree)
  (let ([e (car sn-tree)])
    (if (list? (car e))
        (gen-sn-list (accumulate append '() sn-tree))
        sn-tree)))

(define (gen-sn-tree content pre-sn)
  (map (lambda (a b)
         (let ([sn (append pre-sn (list a))])
           (if (pair? b)
               (gen-sn-tree (cdr b) sn)
               sn)))
       (enumerate-integers 1 (length content))       
       content))
; test
;(gen-sn-tree sicp-content '())
