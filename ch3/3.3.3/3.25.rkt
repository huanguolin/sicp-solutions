#lang scheme

(require r5rs)

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-list)
      (cond ((null? key-list) false)
            ((not (pair? key-list)) )
          (let ((subtable
                 (assoc () (cdr local-table))))
            (if subtable
                (let ((record
                       (assoc key-2 (cdr subtable))))
                  (if record (cdr record) false))
                false))))
    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1 (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))