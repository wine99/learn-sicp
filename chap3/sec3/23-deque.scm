(define (make-deque)
  (let ((front-ptr '())
        (rear-ptr '()))

    (define (empty?)
      (null? front-ptr))

    (define (front)
      (if (empty?)
          (error "FRONT called with an empty deque" deque)
          (caar front-ptr)))

    (define (rear)
      (if (empty?)
          (error "REAR called with an empty deque" deque)
          (caar rear-ptr)))

    (define (flatten)
      (map car front-ptr))

    (define (rear-insert! item)
      (let ((new-pair (cons (cons item rear-ptr) '())))
        (cond ((empty?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair))
              (else
                (set-cdr! rear-ptr new-pair)
                (set! rear-ptr new-pair))))
      (flatten))

    (define (front-insert! item)
      (let ((new-pair (cons (cons item '()) front-ptr)))
        (cond ((empty?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair))
              (else
                (set-cdr! (car front-ptr) new-pair)
                (set! front-ptr new-pair))))
      (flatten))

    (define (front-delete!)
      (if (empty?)
          (error "FRONT-DELETE called with an empty deque" deque)
          (let ((new-front-ptr (cdr front-ptr)))
            (if (null? new-front-ptr)
                (begin (set! rear-ptr '())
                       (set! front-ptr '()))
                (begin (set-cdr! (car new-front-ptr) '())
                       (set! front-ptr new-front-ptr)))))
      (flatten))

    (define (rear-delete!)
      (if (empty?)
          (error "REAR-DELETE called with an empty deque" deque)
          (let ((new-rear-ptr (cdar rear-ptr)))
            (if (null? new-rear-ptr)
                (begin (set! rear-ptr '())
                       (set! front-ptr '()))
                (begin (set-cdr! new-rear-ptr '())
                       (set! rear-ptr new-rear-ptr)))))
      (flatten))

    (define (dispatch m)
      (cond ((eq? m 'empty-deque?) empty?)
            ((eq? m 'front-deque) front)
            ((eq? m 'rear-deque) rear)
            ((eq? m 'flatten) flatten)
            ((eq? m 'front-insert-deque!) front-insert!)
            ((eq? m 'rear-insert-deque!) rear-insert!)
            ((eq? m 'front-delete-deque!) front-delete!)
            ((eq? m 'rear-delete-deque!) rear-delete!)
            (else (error "Undefined oepration"))))

    dispatch))

; TEST

(define deque (make-deque))

((deque 'rear-insert-deque!) 'a)
((deque 'rear-insert-deque!) 'b)
((deque 'rear-insert-deque!) 'c)
((deque 'front-insert-deque!) 'd)
((deque 'front-insert-deque!) 'e)
((deque 'front-insert-deque!) 'f)

(define (repeat n f . args)
  (cond ((<= n 1) (apply f args))
        (else (display (apply f args))
              (newline)
              (apply repeat (- n 1) f args))))

(repeat 5 (deque 'rear-delete-deque!))
((deque 'rear-delete-deque!))

((deque 'rear-insert-deque!) 'a)
((deque 'rear-insert-deque!) 'b)
((deque 'rear-insert-deque!) 'c)
(repeat 2 (deque 'front-delete-deque!))
((deque 'front-delete-deque!))
