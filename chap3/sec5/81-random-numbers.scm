(define random-init 2020)
(define (rand-update x)
  (remainder (+ (* 13 x) 5) 24))

(define (rand request-stream)
  (let ((req (stream-car request-stream)))
    (let ((random-init (if (eq? 'reset (car req))
                           (cadr req)
                           random-init))
          (request-stream (if (eq? 'reset (car req))
                              (stream-cdr request-stream)
                              request-stream)))
      (define random-numbers
        (cons-stream random-init
                     (stream-map
                       (lambda (req rnum)
                         (cond ((eq? 'generate (car req))
                                (rand-update rnum))
                               ((eq? 'reset (car req))
                                (cadr req))
                               (else (error "Wrong request -- RAND" req))))
                       request-stream
                       random-numbers)))
      random-numbers)))

(define s1 (rand (stream '(generate)
                         '(generate)
                         '(generate)
                         '(generate)
                         '(reset 2020)
                         '(generate)
                         '(generate)
                         '(reset 2010)
                         '(generate)
                         '(generate))))

(map (lambda (e)
       (stream-ref s1 e))
     (iota 10))
