(define (fib n)
  (define (fib-iter prev curr count)
    (if (<= count 1)
        curr
        (fib-iter curr (+ prev curr) (- count 1))))

  (if (< n 1)
      n
      (fib-iter 0 1 n)))
