(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
        x
        (- (* x x))))
  (define (d i) (- (* 2 i) 1))
  (define (iter i res)
    (if (< i 1)
        res
        (iter (- i 1)
              (/ (n i)
                 (- (d i) res)))))
  (if (= x 0)
      0
      (/ (iter k 0) x)))


(tan-cf 2.0 1000)
