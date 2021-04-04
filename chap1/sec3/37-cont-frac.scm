(define (cont-frac n d k)
  (define (iter i res)
    (if (< i 1)
        res
        (iter (- i 1)
              (/ (n i)
                 (+ (d i) res)))))
  (iter k 0))


(define (cont-frac-recur n d k)
  (define (iter i)
    (if (> i k)
        0
        (/ (n i)
           (+ (d i)
              (iter (+ i 1))))))
  (iter 1))


(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           1000)

(cont-frac-recur (lambda (i) 1.0)
                 (lambda (i) 1.0)
                 1000)
