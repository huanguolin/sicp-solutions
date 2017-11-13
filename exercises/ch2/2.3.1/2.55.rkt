#lang scheme
(car ''abracadabra)

; 参考：http://community.schemewiki.org/?sicp-ex-2.55
; (car ''something) => 
; (car (quote (quote something))) =>
; quote