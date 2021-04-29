(define (make-table)
  (let ((local-table (list '*table*')))

    (define (lookup keys)
      (define (iter keys table)
        (let ((subtable (assoc (car keys) table)))
          (if subtable
              (if (null? (cdr keys))
                  (cdr subtable)
                  (iter (cdr keys) subtable))
              #f)))
      (iter keys local-table))

    (define (gen-list keys value)
      (if (null? (cdr keys))
          (cons (car keys) value)
          (cons (car keys)
                (cons (gen-list (cdr keys) value)
                      '()))))

    (define (insert! keys value)
      (define (iter keys value table)
        (let ((subtable (assoc (car keys) table)))
          (if subtable
              (if (null? (cdr keys))
                  (set-cdr! subtable value)
                  (iter (cdr keys) value subtable))
              (set-cdr! table
                        (cons (gen-list keys value) (cdr table))))))
      (iter keys value local-table)
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            (else (error "Unknown operation -- TABLE" m))))

    dispatch))
