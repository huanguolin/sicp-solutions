#lang racket

(provide enumerate-integers)

(define (enumerate-integers low high)
  (if (> low high)
      '()
      (cons low
            (enumerate-integers (+ low 1)
                                high))))
