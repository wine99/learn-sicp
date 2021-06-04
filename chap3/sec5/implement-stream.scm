;(define (memo-proc proc)
  ;(let ((already-run? false) (result false))
    ;(lambda ()
      ;(if (not already-run?)
          ;(begin (set! result (proc))
                 ;(set! already-run? true)
                 ;result)
          ;result))))

;; this must be a special execution form
;(define (delay exp)
  ;(memo-proc (lambda () exp)))

;(define (force delayed)
  ;(delayed))

;; this must be a special execution form
;(define (cons-stream a b)
  ;(cons a (delay b)))

;(define (stream-car stream)
  ;(car stream))

;(define (stream-cdr stream)
  ;(if (null? (cdr stream))
      ;'()
      ;(force (cdr stream))))

(define the-empty-stream '())

(define stream-null? null?)

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1)
                                  high))))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream
       (proc (stream-car s))
       (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin
        (proc (stream-car s))
        (stream-for-each proc
                         (stream-cdr s)))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (display-line x)
  (newline)
  (display x))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-stream-n stream n)
  (if (= n 0)
      'done
      (begin (display-line (stream-car stream))
             (display-stream-n (stream-cdr stream) (- n 1)))))

(define (add-streams s1 s2)
  (define (stream-map proc . streams)
    (if (null? (car streams))
        the-empty-stream
        (cons-stream (apply proc (map stream-car streams))
                     (apply stream-map (cons proc
                                             (map stream-cdr streams))))))
  (stream-map + s1 s2))

(define (mul-streams s1 s2)
  (define (stream-map proc . streams)
    (if (null? (car streams))
        the-empty-stream
        (cons-stream (apply proc (map stream-car streams))
                     (apply stream-map (cons proc
                                             (map stream-cdr streams))))))
  (stream-map * s1 s2))

(define (scale-stream stream factor)
  (stream-map
   (lambda (x) (* x factor))
   stream))

(define (partial-sums stream)
  (cons-stream (stream-car stream)
               (add-streams (partial-sums stream)
                            (stream-cdr stream))))

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1)
                          s2)))
                 ((> s1car s2car)
                  (cons-stream
                   s2car
                   (merge s1
                          (stream-cdr s2))))
                 (else
                  (cons-stream
                   s1car
                   (merge
                    (stream-cdr s1)
                    (stream-cdr s2)))))))))
