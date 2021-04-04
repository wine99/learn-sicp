(define (cons1 x y)
  (lambda (which)
    (cond ((= which 0) x)
          ((= which 1) y)
          (else (error "Cons error")))))

(define (car1 z)
  (z 0))

(define (cdr1 z)
  (z 1))

(car1 (cons1 1 2))
(cdr1 (cons1 1 2))



(define (cons2 x y)
  (lambda (select-fn)
    (select-fn x y)))

(define (car2 z)
  (z (lambda (x y) x)))

(define (cdr2 z)
  (z (lambda (x y) y)))

(car2 (cons2 1 2))
(cdr2 (cons2 1 2))
