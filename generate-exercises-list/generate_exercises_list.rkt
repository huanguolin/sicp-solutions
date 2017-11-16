#lang racket

; configure
(define output-file "./exercises_list.md")
(define exercises-root-path "../exercises")

; dependency
(require "./sicp-content/sicp_content.rkt")
(require "./generate_exercises_string.rkt")
(require "./util.rkt")

; functions
(define (proc-content element pre-sn index)
  (let ([sn (append pre-sn (list index))])
    (cond ((pair? element)
           (let ([title (car element)]
                 [content (cdr element)])
             (print-title sn title)
             (for-each (lambda (x y) (proc-content x sn y))
                       content
                       (enumerate-integers 1 (length content)))))
          (else
           (print-title sn element)
           (print-exercises sn)))))

(define (print-title sn title)
  (let ((sn-str (string-join (map number->string sn) ".")))
    (append-line-to-file
     (string-join
      (list (make-string (+ 1 (length sn)) #\#)
            sn-str
            title)
      " ")
     output-file)))

(define (print-exercises sn)
  (define sn-strs (map number->string sn))
  (define path
    (string-append exercises-root-path
                   "/"
                   "ch"
                   (car sn-strs)
                   "/"
                   (string-join sn-strs ".")))
  (append-line-to-file
   (generate-exercises-string path
                              (substring path 1))
   output-file))

; ====== main function ======
(define (main)
  (display-to-file "# SICP Solutions\n\n"
                   output-file
                   #:mode 'text
                   #:exists 'replace)
  (for-each (lambda (x y) (proc-content x '() y))
            sicp-content
            (enumerate-integers 1 (length sicp-content))))
; run main function
(main)

