#lang sicp

(define (cube-root x)
  (define (try guess old-guess)
    (if (good-enough? guess old-guess)
        guess
        (try (improve guess) guess)))

  (define (good-enough? guess old-guess)
    (= guess old-guess))

  (define (improve guess)
    (/ (+ (/ x (* guess guess))
          (* 2 guess))
       3))

  (try 1.0 x))

