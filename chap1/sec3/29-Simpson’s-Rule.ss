#lang sicp

(define (make-even n)
  (+ n (remainder n 2)))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next b) next b))))

(define (simpson f a b n)
  (define fixed-n (make-even n))
  (define h (/ (- b a) fixed-n))
  (define (term k)
    (define y (f (+ a (* k h))))
    (cond ((or (= k 0) (= k fixed-n))
           y)
          ((even? k)
           (* 2 y))
          (else
           (* 4 y))))
  
  (* (/ h 3)
     (sum term 0 + fixed-n)))
