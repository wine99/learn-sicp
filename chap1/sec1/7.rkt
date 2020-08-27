#lang sicp

(define (sqrt x)
  (define (try guess old-guess)
    (if (good-enough? guess old-guess)
        guess
        (try (improve guess) guess)))
  
  (define (good-enough? guess old-guess)
    (= guess old-guess))

  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))
  
  (try 1.0 x))
