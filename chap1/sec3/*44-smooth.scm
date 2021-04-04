(define dx 0.00001)

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))

(define (repeat f n)
  (if (= n 1)
      f
      (lambda (x)
        (f ((repeat f (- n 1)) x)))))


; This is so elegant, how about the correctness?
(define (n-smooth f n)
  ((repeat smooth n) f))
