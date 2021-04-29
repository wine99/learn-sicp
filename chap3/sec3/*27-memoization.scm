(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result
              (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define memo-fib
  (memoize
    (lambda (n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else
              (+ (memo-fib (- n 1))
                 (memo-fib (- n 2))))))))

; The memo-fib works.
; Draw an environment diagram to analyze the computation of (memo-fib 3).

; NOTE! The above fib also works!!!
; Draw environment diagram to see why!

(set! fib (memoize fib))
