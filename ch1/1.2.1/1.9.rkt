#lang scheme
;; (define (+ a b)
;;   (if (= a 0) b (inc (+ (dec a) b))))
;; 执行:
;; (+ 4 5) =>
;; (if (= 4 0) 5 (inc (+ (dec 4) 5))) =>
;; (inc (+ (dec 4) 5) =>
;; (inc (+ 3 5)) ==>
;; (inc (inc (+ 2 5))) ==>
;; (inc (inc (inc (+ 1 5)))) ==>
;; (inc (inc (inc (inc (+ 0 5))))) ==>
;; (inc (inc (inc (inc 5)))) =>
;; (inc (inc (inc 6))) =>
;; (inc (inc 7)) =>
;; (inc 8) =>
;; 9
;; 所以是递归处理(recursive process)

;; (define (+ a b)
;;   (if (= a 0) b (+ (dec a) (inc b))))
;; 执行:
;; (+ 4 5) =>
;; (if (= 4 0) 5 (+ (dec 4) (inc 5))) =>
;; (+ (dec 4) (inc 5)) =>
;; (+ 3 6) ==>
;; (+ 2 7) ==>
;; (+ 1 8) ==>
;; (+ 0 9) ==>
;; 9
;; 所以是迭代处理（iterative process）