(load "implement-stream.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream
        (stream-car s1)
        (interleave s2 (stream-cdr s1)))))

; (s0,t0) (s0,t1) (s0,t2) ...
;         (s1,t1) (s1,t2) ...
;                 (s2,t2) ...
;                         ...
(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x)
                    (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

; (s0,t0) (s0,t1) (s0,t2) ...
; (s1,t0) (s1,t1) (s1,t2) ...
; (s2,t0) (s2,t1) (s2,t2) ...
; ...     ...     ...     ...
(define (full-pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x)
                    (list (stream-car s) x))
                  (stream-cdr t))
      (full-pairs (stream-cdr s) t))))

; Analogous to pairs
; Generate triples (Si, Tj, Uk)
; where i <= j <= k, using pairs
(define (triples s t u)
  (cons-stream
    (list (stream-car s)
          (stream-car t)
          (stream-car u))
    (interleave
      (stream-map (lambda (x)
                    (cons (stream-car s) x))
                  (pairs t u))
      (triples (stream-cdr s)
               (stream-cdr t)
               (stream-cdr u)))))

(define (phythagorean-numbers)
  (define (square x) (* x x))
  (define numbers (triples integers integers integers))
  (stream-filter (lambda (x)
                   (= (square (caddr x))
                      (+ (square (car x)) (square (cadr x)))))
                 numbers))

(display-stream-n (phythagorean-numbers) 5)
