(define (cons x y)
  (lambda (m)
    (m x
       y
       (lambda (n) (set! x n))
       (lambda (n) (set! y n)))))

(define (car pair)
  (pair (lambda (x y sx sy) x)))

(define (cdr pair)
  (pair (lambda (x y sx sy) y)))

(define (set-car! pair new-x)
  (pair (lambda (x y sx sy) (sx new-x))))

(define (set-cdr! pair new-y)
  (pair (lambda (x y sx sy) (sy new-y))))
