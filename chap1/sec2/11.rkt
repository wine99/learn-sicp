#lang sicp

(define (ex1.11-recursive n)
  (if (< n 3)
      n
      (+ (ex1.11-recursive (- n 1))
         (* 2 (ex1.11-recursive (- n 2)))
         (* 3 (ex1.11-recursive (- n 3))))))


(define (ex1.11-iterative n)
  (define (ex1.11-iter curr next next-next count)
    (if (<= count 0)
        curr
        (ex1.11-iter next
                     next-next
                     (+ next-next
                        (* 2 next)
                        (* 3 curr))
                     (- count 1))))
  
  (if (< n 0)
      n
      (ex1.11-iter 0 1 2 n)))
