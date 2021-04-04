(define (same-parity1 first . rest)
  (define yes? (if (even? first)
                   even?
                   odd?))
  (define (recur items)
    (cond ((null? items) '())
          ((yes? (car items))
           (cons (car items)
                 (recur (cdr items))))
          (else (recur (cdr items)))))

  (recur (cons first rest)))

(same-parity1 1 2 3 4 5 6 7)
(same-parity1 2 3 4 5 6 7)

(define (same-parity2 first . rest)
  (define yes? (if (even? first)
                   even?
                   odd?))
  (define (iter collected rest)
    (cond ((null? rest) collected)
          ((yes? (car rest))
           (iter (cons (car rest) collected)
                 (cdr rest)))
          (else (iter collected
                      (cdr rest)))))

  (reverse (iter (list first) rest)))

(same-parity2 1 2 3 4 5 6 7)
(same-parity2 2 3 4 5 6 7)
