(load "70-weighted-pairs.scm")

(define (stream-cadr s) (stream-car (stream-cdr s)))

(define (cube x) (* x x x))
(define (ram-weight pair) (apply + (map cube pair)))

(define (ramanujan-filter s)
  (let ((scar (stream-car s))
        (scadr (stream-cadr s)))
    (if (= (ram-weight scar) (ram-weight scadr))
        (cons-stream (list scar scadr (ram-weight scar))
                     (ramanujan-filter (stream-cdr s)))
        (ramanujan-filter (stream-cdr s)))))

(define ramanujan-numbers
  (ramanujan-filter (weighted-pairs integers integers ram-weight)))

(display-stream-n ramanujan-numbers 5)
