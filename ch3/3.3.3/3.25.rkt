#lang scheme

(require r5rs)

; ref: http://community.schemewiki.org/?sicp-ex-3.25

(define (make-table) 
  (let ((local-table (list '*table*))) 
    (define (assoc key records) 
      (cond ((null? records) false) 
            ((equal? key (caar records)) (car records)) 
            (else (assoc key (cdr records))))) 
    
    (define (lookup key-list) 
      (define (iter keys table) 
        (cond ((null? keys) false) ;;为空时 
              ((null? (cdr keys))  ;;只有一个key时 
               (let ((record (assoc (car keys) (cdr table)))) 
                 (if record 
                     (cdr record) 
                     false))) 
              (else                    ;;有多个key时,先取出一个,用于找到subtable,然后剩下的再循环再 
               (let ((subtable (assoc (car keys) (cdr table)))) 
                 (if subtable 
                     (iter (cdr keys) subtable) 
                     false))))) 
      (iter key-list local-table)) 
    
    (define (insert! value key-list) 
      (define (iter keys table) 
        (cond ((null? table)    ;;这是当没有找到key对应的subtable时，需要创建新的subtable 
               (if (null? (cdr keys)) 
                   (cons (car keys) value) 
                   (list (car keys) (iter (cdr keys) '())))) 
              ((null? (cdr keys)) ;;只有一个key 
               (let ((record (assoc (car keys) (cdr table)))) 
                 (if record 
                     (set-cdr! record value) 
                     (set-cdr! table 
                               (cons (cons (car keys) value) 
                                     (cdr table)))))) 
              (else            ;;有多个key 
               (let ((subtable (assoc (car keys) (cdr table)))) 
                 (if subtable 
                     (iter (cdr keys) subtable) 
                     (set-cdr! table 
                               (cons (list (car keys) 
                                           (iter (cdr keys) '()))   ;;这里是关键，没找到subtable时，创建新的，然后循环(cdr keys) 
                                     (cdr table)))))))) 
      (iter key-list local-table) 
      'ok)     
    (define (dispatch m) 
      (cond ((eq? m 'lookup-proc) lookup) 
            ((eq? m 'insert-proc!) insert!) 
            (else (error "Unknown operation -- TABLE" m)))) 
    dispatch)) 

(define (lookup key-list table) ((table 'lookup-proc) key-list)) 
(define (insert! key-list value table) ((table 'insert-proc!) value key-list)) 

; test
(define table (make-table))
(define keys (list 1 2 3))
(lookup keys table)
(insert! keys 10 table)
(lookup keys table)
(insert! (list 1 2 4 5) 11 table)