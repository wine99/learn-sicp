(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fool-fermat? n expected)
  (define (iter curr n)
    (if (= curr n)
        #t
        (if (= (expmod curr n n) curr)
            (iter (+ curr 1) n)
            #f)))
  (if (eq? (iter 2 n) expected)
      (display "OK")
      (display "Fooled"))
  (newline))

(fool-fermat? 2 true)
(fool-fermat? 13 true)
(fool-fermat? 14 false)

(fool-fermat? 561 false)  ; Carmichael number
(fool-fermat? 1105 false) ; Carmichael number
(fool-fermat? 1729 false) ; Carmichael number
(fool-fermat? 2465 false) ; Carmichael number
(fool-fermat? 2821 false) ; Carmichael number
(fool-fermat? 6601 false) ; Carmichael number
