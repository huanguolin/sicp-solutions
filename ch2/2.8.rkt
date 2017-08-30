#lang scheme
; 预定义函数
(define (make-interval a b) (cons a b))
(define (lower-bound z)
  (min (car z)
       (cdr z)))
(define (upper-bound z)
  (max (car z)
       (cdr z)))

; 相减的时候有三种情况，因为是范围操作，
; 所以有 离、交、含 这三种。
;
; 我们定义从左到右为从负到正,
; 将 x 的范围记作 a-b,
; y 的范围记作 c-d.
; 
; 那么三种情况可以这样表示:
; 离: a-b-c-d 或者 c-d-a-b
; 交: a-c-b-d 或者 c-a-d-b
; 含: a-c-d-b 或者 c-a-b-d
; 可以计算得到(下面可用于分辨三种情况):
; 离: ac ad bc bd 均为正数, 或者均为负数
; 交: ac ad bd 为负数,bc为正数, 或者相反
; 含: ac ad 为负数, bc bd 为正数, 或者相反
; 分析可以知道结果:
; 离: lower-upper
; 交 和 含: 0-upper 或者 lower-0 (到底是
; 哪种取决于lower,upper谁的绝对值大, 因为
; 结果应当是范围大的那个)
(define (sub-interval x y)
  (let ((a (lower-bound x))
        (b (upper-bound x))
        (c (lower-bound y))
        (d (upper-bound y)))
    (let ((ac (- a c))
          (ad (- a d))
          (bc (- b c))
          (bd (- b d)))
      (let ((lower (min ac ad bc bd))
            (upper (max ac ad bc bd))
            (sign (* ac ad bc bd))
            (sign-half (* ac bc)))
      (if (or (< sign 0)
              (and (> sign 0)
                   (< sign-half 0)))
          (make-interval 0
                         (if (> (abs lower)
                                (abs upper))
                             lower
                             upper))
          (make-interval lower upper))))))
; 测试,离
(display "情况1,离: ")
(define x1 (make-interval 5 6))
(define y1 (make-interval 3 4))
(sub-interval x1 y1)
; 测试,交
(display "情况2,交: ")
(define x2 (make-interval 5 9))
(define y2 (make-interval 4 6))
(sub-interval x2 y2)
; 测试,含
(display "情况3,含: ")
(define x3 (make-interval 5 8))
(define y3 (make-interval 2 9))
(sub-interval x3 y3)