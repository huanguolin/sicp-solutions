#lang scheme

; a
(define (get-record division employee-name)
  ((get division 'record)employee-name))

; b
(define (get-salary division record) 
  ((get division 'salary) record)) 

; c
(define (find-employee-record employee-name division-list) 
 (if (null? division-list) 
     #f 
     (or (get-record (car division-list) employee-name) 
         (find-employee-record employee-name (cdr division-list)))))

; d
; 新部门产生，只需要在公司的 table 中安装他们的 record & salary 方法包
