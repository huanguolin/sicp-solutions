#lang scheme

; project
(define (install-project-package)
  ; inner procedure
  (define (rational->integer x)
    (numer x))
  (define (real->rational x)
    (make-rational (round x) 1))
  (define (complex->real x)
    (make-real (real-part x)))
  ; install
  (put 'project 'complex complex->real)
  (put 'project 'real real->rational)
  (put 'project 'rational rational->integer)
  'done)
(define (project x) (apply-generic 'project x))

; drop 
(define (drop a)
  (let ((droped-a (project a)))
    (if (num-eq? droped-a a)
        (drop droped-a)
	a)))

; num-eq? (it can compare the number that have different type)
(define (num-eq? a b) 
 (let ((type1 (type-tag a))
       (type2 (type-tag b)))
   (let ((level1 (level type1)) ; level come from exercise 2.84
         (level2 (level type2)))
     (cond ((= level1 level2) (equ? a b)) ; equ? come from exercise 2.79
           ((< level1 level2) (num-eq? (raise a) b)) ; raise comfrom 2.83
	   (else (num-eq? a (raise b)))))))

; red-efined apply-generic
(define (apply-generic op . args)
  (define (print-error info)
    (error "No method for these types") info)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc    
          (drop (apply proc (map contents args))) ; modify here, drop result
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                   (type2 (cadr type-tags))
                   (a1 (car args))
                   (a2 (cadr args)))
                (let ((level1 (level type1))
                      (level2 (level type2)))
                  (cond ((= level1 level2) (print-error (list op type-tags)))
                        ((> level1 level2) (apply-generic op a1 (raise type2 a2)))
                        (else (apply-generic op (raise type1 a1) a2)))))
              (print-error (list op type-tags)))))))

