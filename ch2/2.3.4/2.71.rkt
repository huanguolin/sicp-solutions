#lang scheme

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
;
; 
; ---------------------------
; n = 10, suppose
; a b c d e  f  g  h   i   j
; 1 2 4 8 16 32 64 128 256 512
; ---------------------------
; encode 'j' need 1 bit,
; and 'a' need (10 - 1) = 9 bits.
;
; 
; ---------------------------
; n
; ---------------------------
; encode the most frequent symbol need 1 bit,
; and the least one need (n - 1) bits.

;
