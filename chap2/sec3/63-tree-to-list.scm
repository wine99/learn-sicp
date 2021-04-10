;1. Do the two procedures produce the same result for every tree? If not, how do the results differ? What lists do the two procedures produce for the trees in Figure 2.16?
;2. Do the two procedures have the same order of growth in the number of steps required to convert a balanced tree with n elements to a list? If not, which one grows more slowly?

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define fig2-16-1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))
(define fig2-16-2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))
(define fig2-16-3 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append
       (tree->list-1
        (left-branch tree))
       (cons (entry tree)
             (tree->list-1
              (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list
         (left-branch tree)
         (cons (entry tree)
               (copy-to-list
                (right-branch tree)
                result-list)))))
  (copy-to-list tree '()))


;a. Both procedures produce the same result because they both are in-order traversals.
;b. Let T(n) be the time taken by the procedure for a balanced tree with n nodes.
;   For tree->list-1:
;   T(n) = 2*T(n/2) + O(n/2) (as the procedure append takes linear time)
;   Solving above equation, we get T(n) = O(n * log n)
;   For tree->list-2:
;   T(n) = 2*T(n/2) + O(1)
;   Solving the above equation, we get T(n) = O(n)
