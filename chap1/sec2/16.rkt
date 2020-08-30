#lang sicp

(define (expt b n)
  (cond ((= n 0) 1)
        ((even? n)
         (expt (* b b) (/ n 2)))
        ((* b (expt b (- n 1))))))
                 