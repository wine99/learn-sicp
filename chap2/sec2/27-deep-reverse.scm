(define (reverse lst)
  (define (iter items res)
    (if (null? items)
        res
        (iter (cdr items)
              (cons (car items) res))))
  (iter lst '()))

; (reverse '(1 2 3))
; (reverse '((1 2) 3))


(define (deep-reverse lst)
  (define (iter items res)
    (if (null? items)
        res
        (iter (cdr items)
              (cons (if (pair? (car items))
                        (deep-reverse (car items))
                        (car items))
                    res))))
  (iter lst '()))

; (deep-reverse '(1 2 3))
; (deep-reverse '((1 2) 3))


(define (deep-reverse2 lst)
  (define (iter items res)
    (if (null? items)
        res
        (iter (cdr items)
              (cons (if (pair? (car items))
                        (iter (car items) '())
                        (car items))
                    res))))
  (iter lst '()))

; (deep-reverse2 '(1 2 3))
; (deep-reverse2 '((1 2) 3))


; Another solution that uses reverse
; REALLY COOL!
;
(define (deep-reverse3 lst)
  (if (pair? lst)
      (reverse (map deep-reverse3 lst))
      lst))

; (deep-reverse3 '(1 2 3))
; (deep-reverse3 '((1 2) 3))

