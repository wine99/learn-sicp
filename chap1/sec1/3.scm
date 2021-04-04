; sum of square of two larger number out of three
(define (ex1.3 a b c)
  (define (sum-sqr x y)
     (+ (* x x) (* y y)))

   (cond
    ((and (<= a b) (<= a c))
     (sum-sqr b c))
    ((and (<= b a) (<= b c))
     (sum-sqr a c))
    ((and (<= c a) (<= c b))
     (sum-sqr a b))))

; test
(ex1.3 3 2 1)
(ex1.3 -1 0 1)

