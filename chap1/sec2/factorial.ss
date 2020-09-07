#lang sicp

(define (factorial n)
  (if (<= n 1)
      n
      (* n (factorial (- n 1)))))


(define (better-fac n)
  (define (fac-iter acc curr n)
    (if (> curr n)
        acc
        (fac-iter
         (* acc curr)
         (+ curr 1)
         n)))

  (fac-iter 1 1 n))