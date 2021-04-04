;; bad solution
(define (expt b n)
  (cond ((= n 0) 1)
        ((even? n)
         (expt (* b b) (/ n 2)))
        (else (* b (expt b (- n 1))))))


;; nice solution, by the hint in the book
(define (expt-fast b n)
  (define (iter res b n)
    (cond ((= n 0) res)
          ((even? n) (iter res (* b b) (/ n 2)))
          (else (iter (* res b) b (- n 1)))))

  (iter 1 b n))


(expt 3 4)
(expt-fast 3 4)
