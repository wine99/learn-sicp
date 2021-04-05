(define zero
  (lambda (f)
    (lambda (x)
      x)))

(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))


; Now what's one and two?

(define one
  (lambda (f)
    (lambda (x)
      (f x))))

(define two
  (lambda (f)
    (lambda (x)
      (f (f x)))))


; What's add?

(define (add a b)
  (lambda (f)
    (lambda (x)
      ((a f) ((b f) x)))))

