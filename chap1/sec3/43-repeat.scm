(define (repeat f n)
  (if (= n 1)
      f
      (lambda (x)
        (f ((repeat f (- n 1)) x)))))

(define (square x)
  (* x x))

((repeat square 1) 5)
((repeat square 2) 5)
((repeat square 3) 5)
