;#lang racket
;(require racket/trace)

(define (fringe1 tree)
  (cond ((null? tree) '())
        ((pair? (car tree))
         (append (fringe1 (car tree))
                 (fringe1 (cdr tree))))
        (else (cons (car tree)
                    (fringe1 (cdr tree))))))

(fringe1 '((1 (2 3)) 4))


(define (fringe2 tree)
  (define (iter tree res)
    (cond ((null? tree) res)
          ((pair? tree)
           (iter (car tree)
                 (iter (cdr tree) res)))
          (else (cons tree res))))
  ;(trace iter)
  (iter tree '()))

(fringe2 '((1 (2 3)) 4))
