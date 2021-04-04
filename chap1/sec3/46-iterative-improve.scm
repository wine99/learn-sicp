(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess)))))


(define (fixed-point f first-guess)
  ((iterative-improve (lambda (guess)
                        (let ((tolerance 0.00001))
                          (< (abs (- guess (f guess))) tolerance)))
                      f)
   first-guess))


(define (sqrt x)
  ((iterative-improve (lambda (guess)
                        (let ((tolerance 0.00001))
                          (< (abs (- (* guess guess) x)) tolerance)))
                      (lambda (guess)
                        (/ (+ guess (/ x guess)) 2)))
   1.0))


(fixed-point cos 0)

(sqrt 4)
