(define (double f)
  (lambda (x) (f (f x))))


((double inc) 0)


(newline)
((double (double inc)) 0)
(((double double) inc) 0)


(newline)
((double (double (double inc))) 0)
(((double double) (double inc)) 0)
((((double double) double) inc) 0)

((double ((double double) inc)) 0)
(((double (double double)) inc) 0)


(newline)
((double (double (double (double inc)))) 0)
(((double double) (double (double inc))) 0)
((((double double) double) (double inc)) 0)
(((((double double) double) double) inc) 0)

(((double (double (double double))) inc) 0)
