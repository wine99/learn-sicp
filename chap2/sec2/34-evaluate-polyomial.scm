(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

; (…((0*x+an)x+an−1)x+⋯+a1)x+a0
; higher-terms * x + this-coef
(define (horner-eval x coef-seq)
  (accumulate (lambda (this-coef higher-terms)
                (+ this-coef
                   (* x higher-terms)))
              0
              coef-seq))

(horner-eval 2 '(1 3 0 5 0 1))
