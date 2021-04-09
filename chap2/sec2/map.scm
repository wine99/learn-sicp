(define (map proc . seqs)
  (define (inner-map proc seq)
    (if (null? seq)
        '()
        (cons (proc (car seq))
              (inner-map proc (cdr seq)))))

  (if (null? (car seqs))
      '()
      (cons (apply proc (inner-map car seqs))
            (apply map proc (inner-map cdr seqs)))))


(map square '(1 2 3))
(map + '(1 2 3) '(2 3 4) '(3 4 5))
