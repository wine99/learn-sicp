(define (for-each fn lst)
  (cond ((not (null? lst))
         (fn (car lst))
         (for-each fn (cdr lst)))))

(for-each
  (lambda (x) (newline) (display x))
  (list 57 321 88))
