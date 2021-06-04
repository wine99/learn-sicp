(load "implement-stream.scm")

;; integers
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))


;; fibs
(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b))))

(define fibs (fib-gen 0 1))


;; primes
(define (divisible? x y) (= (remainder x y) 0))

(define (sieve stream)
  (cons-stream (stream-car stream)
               (sieve (stream-filter
                        (lambda (x)
                          (not (divisible? x (stream-car stream))))
                        (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))


;; ones
(define ones (cons-stream 1 ones))


;; integers
(define integers (cons-stream 1 (add-streams ones integers)))


;; fibs
(define fibs
  (cons-stream
    0 (cons-stream
        1 (add-streams fibs
                       (stream-cdr fibs)))))


;; double
(define double (cons-stream 1 (scale-stream double 2)))

(define double (cons-stream (add-streams double double)))


;; primes
(define primes
  (cons-stream 2 (stream-filter prime? (integers-starting-from 3))))

(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) #t)
          ((divisible? n (stream-car ps)) #f)
          (else (iter (stream-cdr ps)))))
  (iter primes))


;; factorials
(define factorials
  (cons-stream 1 (mul-streams factorials (integers-starting-from 2))))


;; integer-sums
(define integer-sums (partial-sums integers))
;; => (1 3 6 10 15 21 ...


;; integers have no prime factors other than 2, 3 and 5
(define R-Hamming-nums
  (cons-stream 1
               (merge (scale-stream R-Hamming-nums 2)
                      (merge (scale-stream R-Hamming-nums 3)
                             (scale-stream R-Hamming-nums 5)))))
