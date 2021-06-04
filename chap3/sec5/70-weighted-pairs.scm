(load "implement-stream.scm")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (let ((w1 (weight s1car))
                  (w2 (weight s2car)))
              (cond ((< w1 w2)
                     (cons-stream s1car
                                  (merge-weighted (stream-cdr s1) s2 weight)))
                    ((> w1 w2)
                     (cons-stream s2car
                                  (merge-weighted s1 (stream-cdr s2) weight)))
                    (else
                      (cons-stream
                        s1car
                        (cons-stream
                          s2car ;; must include both in case of ties!
                          (merge-weighted
                            (stream-cdr s1)
                            (stream-cdr s2)
                            weight))))))))))

(define (weighted-pairs s t weight)
  (cons-stream (list (stream-car s) (stream-car t))
               (merge-weighted
                 (stream-map (lambda (x) (list (stream-car s) x))
                             (stream-cdr t))
                 (weighted-pairs (stream-cdr s)
                                 (stream-cdr t)
                                 weight)
                 weight)))

(define ex-70-a
  (weighted-pairs integers integers (lambda (pair) (apply + pair))))

(display-stream-n ex-70-a 10)
