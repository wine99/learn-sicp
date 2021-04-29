(define (cycle? lst)
  (define visited '())
  (define (counted? x)
    (memq x visited))
  (define (mark-counted x)
    (set! visited (cons x visited)))
  (define (help? x)
    (cond ((null? x) #f)
          ((counted? x) #t)
          (else
            (mark-counted x)
            (help? (cdr x)))))
  (help? lst))

(define (make-cycle x)
  (define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))

  (set-cdr! (last-pair x) x)
  x)

(define z '(a b c))
(define c (make-cycle '(a b c)))

(cycle? z)
(cycle? c)
