#lang sicp

(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-recur term (next a) next b))))


(define (product term a next b)
  (define (iter a res)
    (if (> a b)
        res
        (iter (next a)
              (* (term a) res))))
  (iter a 1))


(define (fac-recur n)
  (product-recur (lambda (x) x) 1 + n))

(define (fac n)
  (product (lambda (x) x) 1 + n))

