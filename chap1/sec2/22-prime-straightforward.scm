(define (smallest-divisor n)
  (find-divisor n 2))

(define (square x)
  (* x x))


;; prime

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
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


;; timed-prime

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))
      #f))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time)
  #t)


;; exercise 1.21

(define (search-three-prime start)
  (define (search curr count)
    (if (< count 3)
        (search (+ curr 2)
                (if (timed-prime-test curr)
                    (+ count 1)
                    count))))

  (search (if (odd? start)
              start
              (+ start 1))
          0))

(search-three-prime 1000000000)
(search-three-prime 10000000000)
(search-three-prime 100000000000)
(search-three-prime 1000000000000)
