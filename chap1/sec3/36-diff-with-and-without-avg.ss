#lang sicp

(define (fixed-point f first-guess)
  (define tolerance 0.000001)
  (define (try guess count)
    (let ((next (f guess)))
      (display count) (display "  ")
      (display next) (newline)
      (if (close-enough? guess next)
          next
          (try next (+ count 1)))))
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))

  (try first-guess 0))


(define x-to-the-x
  (fixed-point (lambda (x)
                 (/ (log 1000)
                    (log x)))
               10.0))

x-to-the-x
(newline)


(define (average a b) (/ (+ a b) 2))
(define x-to-the-x-with-avg
  (fixed-point (lambda (x)
                 (average x
                          (/ (log 1000)
                             (log x))))
                 10.0))

x-to-the-x-with-avg
  