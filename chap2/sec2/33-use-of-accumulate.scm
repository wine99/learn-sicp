(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


(define (map proc sequence)
  (accumulate (lambda (x y)
                (cons (proc x) y))
              '()
              sequence))

(map square '(1 2 3))


(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(append '(1 2 3) '(4 5 6))


(define (length sequence)
  (accumulate (lambda (x y)
                (+ 1 y))
              0
              sequence))

(length '(1 2 3))
