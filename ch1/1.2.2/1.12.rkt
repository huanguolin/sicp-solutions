#lang scheme
(define (element-pascal-triangle row num)
  (cond ((= num 1) 1)
        ((= row num) 1)
        (else (+ (element-pascal-triangle (- row 1)
                                          (- num 1))
                 (element-pascal-triangle (- row 1)
                                          num)))))
;; test (element-pascal-triangle 5 1) => 1
;; test (element-pascal-triangle 4 2) => 3
;; test (element-pascal-triangle 5 3) => 6
