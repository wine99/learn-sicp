;; @woofy from http://community.schemewiki.org/?sicp-ex-4.31

(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
           procedure
           (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameter-names procedure)
             (compound-procedure-args procedure arguments env)
             (procedure-environment procedure))))
        (else
          (error "Unknown procedure type -- APPLY" procedure))))

(define (lazy-param? param) (eq? 'lazy (cadr param)))
(define (lazy-memo-param? param) (eq? 'lazy-memo (cadr param)))
(define (eager-param? param) (symbol? param))

(define (compound-procedure-args procedure arguments caller-env)
  (define (build-list params arg-exps)
    (define (build param exp)
      (cond ((eager-param? param) (actual-value exp caller-env))
            ((lazy-param? param) (delay-it exp caller-env))
            ((lazy-memo-param? param) (delay-it-memo exp caller-env))
            (else (error "Invalid paramemeter specification -- COMPOUND-PROCEDURE-ARGS" param))))
    (map build params arg-exps))
  (build-list (procedure-parameters procedure) arguments))

(define (actual-value exp env)
  (force-it (eval exp env)))

(define (delay-it exp env) (list 'thunk exp env))
(define (delay-it-memo exp env) (list 'thunk-memo exp env))
(define (thunk? obj) (tagged-list? obj 'thunk))
(define (thunk-memo? obj) (tagged-list? obj 'thunk-memo))
(define (thunk-exp thunk) (cadr thunk))
(define (thunk-env thunk) (caddr thunk))
(define (evaluated-thunk? obj) (tagged-list? obj 'evaluated-thunk))
(define (thunk-value evaluated-thunk) (cadr evaluated-thunk))

(define (force-it obj)
  (cond ((thunk? obj) (actual-value (thunk-exp obj) (thunk-env obj)))
        ((thunk-memo? obj)
         (let ((result (actual-value (thunk-exp obj) (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)
           (set-cdr! (cdr obj) '())
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))

(define (procedure-parameter-names p)
  (map (lambda (x) (if (pair? x) (car x) x)) (procedure-parameters p)))
