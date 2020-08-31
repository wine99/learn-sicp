#lang sicp

; TODO
; What is (A 0 n), (A 1 n), (A 2 n)?
; What about (A 3 n)?

; Ackermann’s function

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
