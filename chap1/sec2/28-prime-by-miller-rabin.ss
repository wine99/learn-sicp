#lang sicp

(define (square-with-check x n)
  (let ((square (* x x)))
    (if (or (= x 1)
            (= x (- n 1))
            (not (= square 1))) ; (remainder 1 n) = 1
        square
        0)))                    ; (remainder 0 n) = 0


(define (expmod base exp m) 
  (cond ((= exp 0) 1) 
        ((even? exp) 
         (remainder (square-with-check (expmod base (/ exp 2) m) m)
                    m)) 
        (else 
         (remainder (* base (expmod base (- exp 1) m)) 
                    m))))

(define (fool-miller-rabin? n expected)
  (define (iter curr n)
    (if (= curr n)
        #t
        (if (= (expmod curr (- n 1) n) 1)
            (iter (+ curr 1) n)
            #f)))
  (if (eq? (iter 2 n) expected)
      (display "OK")
      (display "Fooled"))
  (newline))


(fool-miller-rabin? 2 true) 
(fool-miller-rabin? 13 true) 
(fool-miller-rabin? 14 false)
(fool-miller-rabin? 15 false)
  
(fool-miller-rabin? 561 false)  ; Carmichael number
(fool-miller-rabin? 1105 false) ; Carmichael number
(fool-miller-rabin? 1729 false) ; Carmichael number
(fool-miller-rabin? 2465 false) ; Carmichael number
(fool-miller-rabin? 2821 false) ; Carmichael number
(fool-miller-rabin? 6601 false) ; Carmichael number
