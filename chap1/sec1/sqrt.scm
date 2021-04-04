(define (try guess x)
  (if (good-enough? guess x)
      guess
      (try (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- guess (/ x guess))) 0.0001))

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))


(define (sqrt x)
  (try 1.0 x))


(define (another-sqrt x)
  (define (try guess)
    (if (good-enough? guess)
        guess
        (try (improve guess))))

  (define (good-enough? guess)
    (< (abs (- guess (/ x guess))) 0.0001))

  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))

  (try 1.0))
