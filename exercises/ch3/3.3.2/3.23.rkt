#lang scheme

(require r5rs)

(define (make-deque)
  (let ((head-ptr null)
        (tail-ptr null)) 
    
    (define (empty-deque?) 
      (or (null? head-ptr)
          (null? tail-ptr)))
    
    (define (print-deque-from-front)
      (define (cur-val cur-ptr) (car cur-ptr))
      (define (next-ptr cur-ptr) (cadr cur-ptr))
      (define (iter ptr)
        (if (null? ptr)
            (display ")")
            (let ((next (next-ptr ptr)))
              (begin
                (display (cur-val ptr)) 
                (display (if (null? next) "" " "))
                (iter next)))))
      (display "FRONT->(")
      (if (empty-deque?) 
          (display ")")
          (iter head-ptr))
      (newline))
    (define (print-deque-from-rear)
      (define (cur-val cur-ptr) (car cur-ptr))
      (define (next-ptr cur-ptr) (cddr cur-ptr))
      (define (iter ptr)
        (if (null? ptr)
            (display ")")
            (let ((next (next-ptr ptr)))
              (begin
                (display (cur-val ptr)) 
                (display (if (null? next) "" " "))
                (iter next)))))
      (display "REAR->(")
      (if (empty-deque?) 
          (display ")")
          (iter tail-ptr))
      (newline))
    
    (define (front-deque) 
      (if (empty-deque?)
          (error "FRONT called with an empty deque")
          (car head-ptr)))
    (define (rear-deque) 
      (if (empty-deque?)
          (error "REAR called with an empty deque")
          (car tail-ptr)))
    
    (define (front-insert-deque! item)
      (let ((new-pair (cons item (cons null null))))
        (cond ((empty-deque?)
               (set! head-ptr new-pair)
               (set! tail-ptr new-pair))
              (else 
               (set-car! (cdr new-pair) head-ptr)
               (set-cdr! (cdr head-ptr) new-pair)
               (set! head-ptr new-pair)))))
    (define (rear-insert-deque! item)
      (let ((new-pair (cons item (cons null null))))
        (cond ((empty-deque?)
               (set! head-ptr new-pair)
               (set! tail-ptr new-pair))
              (else 
               (set-car! (cdr tail-ptr) new-pair)
               (set-cdr! (cdr new-pair) tail-ptr)
               (set! tail-ptr new-pair)))))
    
    (define (front-delete-deque!)
      (cond ((empty-deque?)
             (error "FRONT-DELETE! called with an empty deque"))
            (else 
             (set! head-ptr (cadr head-ptr))
             (if (not (null? head-ptr)) 
                 (set-cdr! (cdr head-ptr) null)))))
    (define (rear-delete-deque!)
      (cond ((empty-deque?)
             (error "REAR-DELETE! called with an empty deque"))
            (else 
             (set! tail-ptr (cddr tail-ptr))
             (if (not (null? tail-ptr)) 
                 (set-car! (cdr tail-ptr) null)))))
    
    (define (dispatch m) 
      (cond ((eq? m 'empty-deque?) empty-deque?)
            ((eq? m 'print-deque-from-front) print-deque-from-front)
            ((eq? m 'print-deque-from-rear) print-deque-from-rear)	
            ((eq? m 'front-deque) front-deque)
            ((eq? m 'rear-deque) rear-deque)
            ((eq? m 'front-insert-deque!) front-insert-deque!)
            ((eq? m 'rear-insert-deque!) rear-insert-deque!)
            ((eq? m 'front-delete-deque!) front-delete-deque!)
            ((eq? m 'rear-delete-deque!) rear-delete-deque!)
            (else 
             (error "DISPATCH-DEQUE! Unknown function name!"))))
    dispatch))
(define (print-deque-from-front q) ((q 'print-deque-from-front)))
(define (print-deque-from-rear q) ((q 'print-deque-from-rear)))
(define (empty-deque? q) ((q 'empty-deque?)))
(define (front-deque q) ((q 'front-deque)))
(define (rear-deque q) ((q 'rear-deque)))
(define (front-insert-deque! q item) ((q 'front-insert-deque!) item))
(define (rear-insert-deque! q item) ((q 'rear-insert-deque!) item))
(define (front-delete-deque! q) ((q 'front-delete-deque!)))
(define (rear-delete-deque! q) ((q 'rear-delete-deque!)))


; test
(define q (make-deque))

(empty-deque? q)
(print-deque-from-front q)

(front-insert-deque! q 'a)
(print-deque-from-front q)

(front-insert-deque! q 'b)
(print-deque-from-front q)

(front-insert-deque! q 'c)
(print-deque-from-front q)
(print-deque-from-rear q)

(rear-delete-deque! q)
(print-deque-from-rear q)
(rear-delete-deque! q)
(print-deque-from-rear q)
(rear-delete-deque! q)
(print-deque-from-rear q)
(empty-deque? q)

(rear-insert-deque! q '1)
(rear-insert-deque! q '2)
(rear-insert-deque! q '3)
(print-deque-from-rear q)
(rear-delete-deque! q)
(print-deque-from-rear q)
(rear-delete-deque! q)
(print-deque-from-rear q)
(rear-delete-deque! q)
(print-deque-from-rear q)

