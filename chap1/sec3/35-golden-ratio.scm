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


; works with or without averaging
(define (average a b) (/ (+ a b) 2))
(define golden-ratio
  (fixed-point (lambda (x)
                 ;(average x
                          (+ 1 (/ 1 x)));)
               1.0))

golden-ratio
