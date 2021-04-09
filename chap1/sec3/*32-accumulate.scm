; This is actually right fold!
(define (accumulate-recur combiner null-val term a next b)
  (if (> a b)
      null-val
      (combiner (term a)
                (accumulate-recur combiner
                                  null-val
                                  term
                                  (next a)
                                  next
                                  b))))

; And this is left fold!
(define (accumulate combiner null-val term a next b)
  (define (iter a res)
    (if (> a b)
        res
        (iter (next a)
              (combiner res (term a)))))
              ;(combiner (term a) res))))
  (iter a null-val))

(accumulate cons '() (lambda (x) x) 1 (lambda (x) (+ x 1)) 5)
(accumulate-recur cons '() (lambda (x) x) 1 (lambda (x) (+ x 1)) 5)


; After learning list, we can rewrite fold.

(define (fold-right op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (fold-right op initial (cdr seq)))))

(define (fold-left op initial seq)
  (if (null? seq)
      initial
      ;(fold-left op (op (car seq) initial) (cdr seq))))
      (fold-left op (op initial (car seq)) (cdr seq))))

(fold-right cons '() '(1 2 3 4))
(fold-left cons '() '(1 2 3 4))
(fold-right / 1 '(1 2 3 4))
(fold-left / 1 '(1 2 3 4))
