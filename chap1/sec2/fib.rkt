#lang sicp

(define (fib n)
  (define (fib-iter curr next count)
    (if (<= count 0)
        curr
        (fib-iter next (+ curr next) (- count 1))))

  (fib-iter 0 1 n))
