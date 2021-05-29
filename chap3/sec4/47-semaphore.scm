;; from book

(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          val))
      serialized-p)))

(define (make-mutex)
  (let ((cell (list #f)))
    (define (the-mutex msg)
      (cond ((eq? msg 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire)))
            ((eq? msg 'release)
             (clear! sell))))
    the-mutex))

(define (clear! cell)
  (set-car! cell #f))

;; this must an atomic operation
(define (test-and-set! cell)
  (if (car cell)
      #t
      (begin (set-car! cell #t)
             #f)))


;; answer to the exercise

(define (make-serializer-n n)
  (let ((semaphore (make-semaphore n)))
    (lambda (p)
      (define (serialized-p . args)
        (semaphore 'acquire)
        (let ((val (apply p args)))
          (semaphore 'release)
          val))
      serialized-p)))

(define (make-semaphore n)
  (let ((count-mutex make-mutex))
    (define (the-semaphore msg)
      (cond ((eq? msg 'acquire)
             (count-mutex 'acquire)
             (if (<= n 0)
                 (begin (count-mutex 'release) (the-semaphore 'acquire))
                 (begin (set! n (- n 1)) (count-mutex 'release))))
            ((eq? msg 'release)
             (count-mutex 'acquire)
             (set! n (+ n 1))
             (count-mutex 'release))))
    the-semaphore))
