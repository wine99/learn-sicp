(define (count-pairs x)
  (define visited '())
  (define (counted? x)
    (memq x visited))
  (define (mark-counted x)
    (set! visited (cons x visited)))
  (define (count x)
    (cond ((null? x) 0)
          ((not (pair? x)) 0)
          (else
            (if (counted? x)
                0
                (begin
                  (mark-counted x)
                  (+ (count (car x))
                     (count (cdr x))
                     1))))))
  (count x))

(count-pairs '(a b c d))
