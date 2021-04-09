(define (map proc seq)
  (if (null? seq)
      '()
      (cons (proc (car seq))
            (map proc (cdr seq)))))

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))


(define (count-leaves tree)
  (accumulate +
              0
              (map (lambda (sub-tree)
                     (cond ((null? sub-tree) 0)
                           ((pair? sub-tree) (count-leaves sub-tree))
                           (else 1)))
                   tree)))

(count-leaves '(1 2 (3 4) (5 (6 7))))
(count-leaves '(1 2 () () (3 () ())))
