;; another excercise for writing iteration
;; similar to ex16

(define (double n) (+ n n))
(define (half n) (/ n 2))

(define (* a b)
  (define (iter res a b)
    (cond ((= b 0) res)
          ((even? b) (iter res (double a) (half b)))
          (else (iter (+ res a) a (- b 1)))))

  (iter 0 a b))

(* 3 6)
