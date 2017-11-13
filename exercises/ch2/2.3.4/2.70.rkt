#lang scheme

(require "generate-huffman-tree.rkt"
	 "encode.rkt"
	 "decode.rkt")

(define the-tree (generate-huffman-tree
		   '((WAH 1)
		     (BOOM 1)
		     (A 2)
		     (GET 2)
		     (JOB 2)
		     (SHA 3)
		     (YIP 9)
		     (NA 16))))
(define msg '(GET A JOB 
              SHA NA NA NA NA NA NA NA NA 
	      GET A JOB
	      SHA NA NA NA NA NA NA NA NA 
	      WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP 
	      SHA BOOM))
(define encode-msg (encode msg the-tree))

(display "message: ")
(newline)
(decode encode-msg the-tree)
(display "encode result: ")
(display encode-msg)
(newline)

(display "encode message length: ")
(length encode-msg)
(display "use fixed-length code, need length: ")
(display (* 3 (length msg)))

