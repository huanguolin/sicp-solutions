#lang scheme
; ---------------------------
; reference from 2.71
; ---------------------------
; n = 5, suppose
; a b c d e
; 1 2 4 8 16
; tree:
; 31{a b c d e}
; |   \  
; |    \
; 16{e} 15{a b c d}
;       |  \
;       |   \
;       8{d} 7{a b c}
;            |  \
;            |   \
;            4{c} 3{a b}
;                 |  \
;                 |   \
;                 2{b} 1{a}
; ---------------------------
; encode 'e' need 1 bit,
; and 'a' need 4 bits.
; ---------------------------
; 

; ---------------------------
; answer
; ---------------------------
; give the order of growth (as a function of n)
; of the number of steps needed to encode the 
; most frequent: 
; T(n) =   2   *   1 = O(1)
;      list-has? 'search-in-tree'
; 
; and least frequent symbols in the alphabet:
; T(n) = 2(n-1) + 2(n-2) + ... + 2 
;      = 2((n-1)+(n-2)+...+1)
;      = 2((n-1)*n/2)
;      = n^2 - n
;      = O(n^2)