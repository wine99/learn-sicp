(define (make-instruction text)
  (list text '() 'nolabel))

(define (make-instruction-with-label text label)
  (list text '() label))

(define (instruction-text inst)
  (car inst))

(define (instruction-execution-proc inst)
  (cadr inst))

(define (instruction-label inst)
  (caddr inst))

(define (set-instruction-execution-proc! inst proc)
  (set-car! (cdr inst) proc))


(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels
        (cdr text)
        (lambda (insts labels)
          (let ((next-inst (car text)))
            (if (symbol? next-inst)
                (if (label-exist? labels next-inst)
                    (error "the label has existed -- EXTRACT-LABELS" next-inst)
                    (receive (begin (set-car! insts
                                              (make-instruction-with-label
                                                (instruction-text (car insts))
                                                next-inst))
                                    insts)
                             (cons (make-label-entry next-inst
                                                     insts)
                                   labels)))
                (receive (cons (make-instruction next-inst)
                               insts)
                         labels)))))))

(define (execute)
  (let ((insts (get-contents pc)))
    (if (null? insts)
        'done
        (let ((inst (car insts)))
          (if trace-on
              (begin (if (not (null? (instruction-label inst)))
                         (begin (display (instruction-label inst))
                                (newline)))
                     (display (instruction-text inst))
                     (newline)))
          ((instruction-execution-proc inst))
          (execute)))))
