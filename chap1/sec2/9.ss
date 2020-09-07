#lang sicp

(define (+ a b)
  (cond ((< a 0)
         (dec (+ (inc a) b)))
        ((> a 0)
         (inc (+ (dec a) b)))
        (else b)))

(define (better-+ a b)
  (cond ((< a 0)
         (+ (inc a) (dec b)))
        ((> a 0)
         (+ (dec a) (inc b)))
        (else b)))
