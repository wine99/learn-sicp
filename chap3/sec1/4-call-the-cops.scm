(define (make-account balance password)
  (define count 0)
  (define limit 3)
  (define (call-the-cops) "Call the cops")

  (define (withdraw amount)
    (set! count 0)
    (cond ((>= balance amount)
           (set! balance (- balance amount))
           balance)
          (else "Insufficient funds")))

  (define (deposit amount)
    (set! count 0)
    (set! balance (+ balance amount))
    balance)

  (define (wrong-password amount)
    (cond ((>= count limit) (call-the-cops))
          (else (set! count (+ count 1))
                "Wrong password")))

  (define (dispatch pass cmd)
    (cond ((not (eq? pass password)) wrong-password)
          ((eq? cmd 'withdraw) withdraw)
          ((eq? cmd 'deposit) deposit)
          (else (error "Unknown command -- MAKE-ACCOUNT"))))

  dispatch)
