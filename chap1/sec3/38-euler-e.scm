(define (cont-frac n d k)
  (define (iter i res)
    (if (< i 1)
        res
        (iter (- i 1)
              (/ (n i)
                 (+ (d i) res)))))
  (iter k 0))


(define (n i) 1)

(define (d i)
  (if (= (remainder i 3) 2)
      (/ (+ i 1) 1.5)
      1))

(define e
  (+ 2
     (cont-frac n d 1000)))

e
