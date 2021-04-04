(define (reverse1 lst)
  (if (null? lst)
      lst
      (append (reverse1 (cdr lst)) (list (car lst)))))

(reverse1 '())
(reverse1 '(1 2 3))

(list 1 2 3)
(define (reverse2 lst)
  (define (iter collected rest)
    (if (null? rest)
        collected
        (iter (cons (car rest) collected)
              (cdr rest))))

  (iter '() lst))

(reverse1 '())
(reverse1 '(1 2 3))
