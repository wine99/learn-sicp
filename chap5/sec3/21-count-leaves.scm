(define count-leaves-machine
  (make-machine
    '(continue val tree tmp)
    (list (list '+ +)
          (list 'null? null?)
          (list 'symbol? symbol?)
          (list 'integer? integer?) (list 'car car) (list 'cdr cdr))
    '((assign continue (label count-leaves-done))

      tree-loop
      (test (op null?) (reg tree))
      (branch (label null-case))
      (test (op symbol?) (reg tree))
      (branch (label atom-case))
      (test (op integer?) (reg tree))
      (branch (label atom-case))

      (save continue)
      (save tree)
      (assign continue after-left-tree)
      (assign tree (op car) (reg tree))
      (goto (label tree-loop))

      after-left-tree
      (restore tree)
      (restore continue)
      (save continue)
      (save val)
      (assign (label after-right-tree))
      (assign tree (op cdr) (reg tree))
      (goto (label tree-loop))

      after-right-tree
      (assign tmp (reg val))
      (restore val)
      (restore continue)
      (assign val (op +) (reg val) (reg tmp))
      (goto (reg continue))

      null-case
      (assign val (const 0))
      (goto (reg continue))

      atom-case
      (assign val (const 1))
      (goto (reg continue))

      count-leaves-done)))
