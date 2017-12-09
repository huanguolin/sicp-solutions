#lang racket

; configure
(define output-file "./README.md")
(define file-header
  '("# sicp-solutions" 
    "> My solutions for SICP exercises."))
(define file-license
  '("# License"
    "- Code: [MIT](https://opensource.org/licenses/MIT)" 
    "- Note: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)"))

; dependency
(require "./generate_exercises_table_string.rkt")
(require "./util.rkt")

; ====== main function ======
(define (main)  
  (display-to-file (string-append
                    (string-join file-header "\n")
                    "\n\n")
                   output-file
                   #:mode 'text
                   #:exists 'replace)
  (append-lines-to-file
   (generate-exercises-table-lines)
   output-file)
  (append-lines-to-file
   (append '("\n") file-license)
   output-file))
; run main function
(main)