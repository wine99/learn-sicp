(define (accumulate-recur combiner null-val term a next b)
  (if (> a b)
      null-val
      (combiner (term a)
                (accumulate-recur combiner
                                  null-val
                                  term
                                  (next a)
                                  next
                                  b))))

(define (accumulate combiner null-val term a next b)
  (define (iter a res)
    (if (> a b)
        res
        (iter (next a)
              (combiner res (term a)))))
  (iter a null-val))
