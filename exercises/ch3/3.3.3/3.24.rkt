#lang scheme

(require r5rs)

(define (make-table same-key?) 
  (let ((table (list '*table*)))
    (define (assoc key records)
      (cond ((null? records) false)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records))))) 
    (define (lookup key)
      (let ((record (assoc key (cdr table))))
        (if record
            (cdr record)
            false)))
    (define (insert! key value)
      (let ((record (assoc key (cdr table))))
        (if record
            (set-cdr! record value)
            (set-cdr! table
                      (cons (cons key value)
                            (cdr table)))))
      'ok)
    
    (define (dispatch m) 
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            (else 
             (error "DISPATCH-TALBLE! Unknown function name!"))))
    dispatch))

(define (insert-table! key value table)
  ((table 'insert!) key value))

(define (lookup-table key table)
  ((table 'lookup) key))

; test
; case 1 - old table type
(define table-1 (make-table equal?))
(insert-table! (list 1) (list '1-1) table-1)
(insert-table! (list 2) (list '1-2) table-1)
(lookup-table (list 1) table-1)
(lookup-table (list 2) table-1)

; case 2 - new table type
(define (same-int? int1 int2)
  (= (round int1) (round int2)))
(define table-2 (make-table same-int?))
(insert-table! 1.3 '1.3 table-2)
(insert-table! 1.5 '1.5 table-2)
(insert-table! 1.7 '1.7 table-2)
(insert-table! -0.4 '-0.4 table-2)
(lookup-table 1.3 table-2)
(lookup-table 1.5 table-2)
(lookup-table 1.7 table-2)
(lookup-table -0.4 table-2)