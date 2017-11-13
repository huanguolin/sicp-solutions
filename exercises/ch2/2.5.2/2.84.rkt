#lang scheme

(define (level type) 
   (cond ((eq? type 'integer) 0) 
         ((eq? type 'rational) 1) 
         ((eq? type 'real) 2) 
         ((eq? type 'complex) 3) 
         (else (error "Invalid type: LEVEL" type)))) 

(define (apply-generic op . args)
  (define (print-error info)
    (error "No method for these types") info)

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
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

