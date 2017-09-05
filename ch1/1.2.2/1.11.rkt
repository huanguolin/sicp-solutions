#lang scheme
;; recursive process
(define (rf n)
  (if (< n 3)
      n
      (+ (rf (- n 1))
         (* 2
            (rf (- n 2)))
         (* 3
            (rf (- n 3))))))
;; test (rf 3) => 4
;; test (rf 4) => 11

;; iterative process
(define (itf n)
  (define (iter a b c count)
    (define (fm) (+ a
                    (* 2 b)
                    (* 3 c)))
    (if (= count n)
        (fm)
        (iter (fm)
              a
              b
              (+ count
                 1))))
  (if (< n 3)
      n
      (iter 2 1 0 3)))
;; test (itf 3) => 4
;; test (itf 4) => 11
;; test (itf 20) => 10771211