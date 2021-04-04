(define (sum term a next b)
  (define (iter a res)
    (if (> a b)
        res
        (iter (next a)
              (+ res
                 (term a)))))
  (iter a 0))
