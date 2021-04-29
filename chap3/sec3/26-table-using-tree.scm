(define (make-record key value)
  (list (cons key value) '() '()))
(define (get-key record) (caar record))
(define (get-value record) (cdar record))
(define (set-key! record new-key) (set-car! (car record) new-key))
(define (set-value! record new-value) (set-cdr! (car record) new-value))
(define (get-left record) (cadr record))
(define (get-right record) (caddr record))
(define (set-left! record new-left) (set-car! (cdr record) new-left))
(define (set-right! record new-right) (set-car! (cddr record) new-right))

(define (assoc key records)
  (cond ((null? records) #f)
        ((equal? key (get-key records)) (get-value records))
        ((< key (get-key records)) (assoc key (get-left records)))
        (else (assoc key (get-right records)))))

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
