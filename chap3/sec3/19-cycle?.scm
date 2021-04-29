(define (cycle? lst)
  (define (help? slow-ptr fast-ptr)
    (cond ((eq? slow-ptr fast-ptr) #t)
          ((or (null? (cdr fast-ptr))
               (null? (cddr fast-ptr)))
           #f)
          (else (help? (cdr slow-ptr) (cddr fast-ptr)))))
  (help? lst (cdr lst)))

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
