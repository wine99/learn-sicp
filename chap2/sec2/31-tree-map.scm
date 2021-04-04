(define (tree-map1 proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map1 proc sub-tree)
             (proc sub-tree)))
       tree))

(define (tree-map2 proc tree)
  (cond ((null? tree) '())
        ((pair? tree)
         (cons (tree-map2 proc (car tree))
               (tree-map2 proc (cdr tree))) )
        (else (proc tree))))

(define (square-tree1 tree) (tree-map1 square tree))
(define (square-tree2 tree) (tree-map2 square tree))

(square-tree1 '((1 (2 3)) 4))
(square-tree2 '((1 (2 3)) 4))

