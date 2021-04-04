; TODO
; This original expmod procedure is absolutely smart and quick.
; But why is it correct? How did it work?

(define (square x)
  (display "square ")(display x)(newline)
  (* x x))

(define (expmod base exp m)
  (display exp) (display "  ") (newline)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (expmod-another base exp m)
  (remainder (fast-expt base exp) m))
(define (fast-expt b n)
  (cond ((= n 0)
         1)
        ((even? n)
         (square (fast-expt b (/ n 2))))
        (else
         (* b (fast-expt b (- n 1))))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n)
         (fast-prime? n (- times 1)))
        (else false)))

(expmod 4 17 17)
(newline)
(expmod-another 4 17 17)
