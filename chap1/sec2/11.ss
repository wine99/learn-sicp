#lang sicp

(define (ex1.11-recursive n)
  (if (< n 3)
      n
      (+ (ex1.11-recursive (- n 1))
         (* 2 (ex1.11-recursive (- n 2)))
         (* 3 (ex1.11-recursive (- n 3))))))


(define (ex1.11-iterative n)
  (define (ex1.11-iter preprev prev curr count)
    (if (<= count 2)
        curr
        (ex1.11-iter prev
                     curr
                     (+ curr
                        (* 2 prev)
                        (* 3 preprev))
                     (- count 1))))
  
  (if (< n 2)
      n
      (ex1.11-iter 0 1 2 n)))
