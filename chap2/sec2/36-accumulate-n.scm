(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))


(define (accumulate-n op initial seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op initial (map car seqs))
            (accumulate-n op initial (map cdr seqs)))))

(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
;; => (22 26 30)
