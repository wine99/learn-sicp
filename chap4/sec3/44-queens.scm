;; from @woofy http://community.schemewiki.org/?sicp-ex-4.44

(define (no-conflict col board)
    (define (iter next k)
        (or (null? next)
            (and (not (= (car next) col))
                 (not (= (car next) (- col k))
                 (not (= (car next) (+ col k)))))
                 (iter (cdr next) (+ k 1))))
    (iter board 1))

(define (queens n)
    (define (iter row result)
        (if (= row n)
            (display result)
            (let ((col (an-integer-between 0 (- n 1))))
                (require (no-conflict col result))
                (iter (+ row 1) (cons col result)))))
    (iter 0 '()))
