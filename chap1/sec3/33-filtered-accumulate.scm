; fa: filtered-accumulate
(define (fa combiner null-val term a next b predicate)
  (define (iter a res)
    (if (> a b)
        res
        (iter (next a)
              (if (predicate a)
                  (combiner res (term a))
                  res))))
  (iter a null-val))


(define (sum-of-prime-squares a b)
  (fa +
      0
      (lambda (x) (* x x))
      a
      inc
      b
      (lambda (a) (prime? a))))


(define (product-of-relative-primes n)
  (fa *
      1
      (lambda (x) x)
      1
      inc
      n
      (lambda (a) (= (gcd a n) 1))))



(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (* test-divisor test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))
