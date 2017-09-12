#lang scheme

; import procedures

(require "2.64.rkt")

; implement lookup use binary tree data structure
(define (lookup give-key records)
  (if (null? records) 
      false
      (let ((record (entry records)))
	(let ((key (car record))
	      (value (cadr record)))
	  (cond ((= give-key key) record)
		((< give-key key) (lookup give-key (left-branch records)))
		(else (lookup give-key (right-branch records))))))))
; test 
(define list-records '((1 "jack") (3 "alvin") (5 "jake") 
			(7 "allen") (9 "alice") (11 "peter")))
(define records (list->tree list-records))

(display "records: ")
(display records)
(newline)
(display "find 9: ")
(lookup 9 records)
(newline)
(display "find 1: ")
(lookup 1 records)
(newline)
