; the word tree means both non-leaf-tree and leaf

; leaf looks like this: ('leaf 'A 4)
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? tree) (eq? (car tree) 'leaf))
(define (symbol-leaf leaf) (cadr leaf))
(define (weight-leaf leaf) (caddr leaf))

; tree (non-leaf) looks like this: ((...) (...) ('A 'B) 6)
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

; add a tree/leaf to a weight ascending tree/leaf set
(define (adjoin-set tree set)
  (cond ((null? set) (list tree))
        ((< (weight tree) (weight (car set))) (cons tree set))
        (else (cons (car set)
                    (adjoin-set tree (cdr set))))))

; argument pairs looks like this: ((A 4) (B 2) (C 1) (D 1))
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (adjoin-set (make-leaf (car (car pairs))
                             (cadr (car pairs)))
                  (make-leaf-set (cdr pairs)))))

(define (successive-merge tree-set)
  (if (= (length tree-set) 1)
      (car tree-set)
      (successive-merge (adjoin-set (make-code-tree (car tree-set)
                                                    (cadr tree-set))
                                    (cddr tree-set)))))

(generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))


(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch (choose-branch (car bits)
                                          current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))

  (define (choose-branch bit branch)
    (cond ((= bit 0) (left-branch branch))
          ((= bit 1) (right-branch branch))
          (else (error "bad bit:
                       CHOOSE-BRANCH" bit))))

  (decode-1 bits tree))

(define (encode message tree)
  (define (encode-symbol symbol tree)
    (if (leaf? tree)
        (if (eq? symbol (symbol-leaf tree))
            '()
            (error "bad symbol: ENCODE-SYMBOL" symbol))
        (if (memq symbol (symbols (left-branch tree)))
            (cons 0 (encode-symbol symbol (left-branch tree)))
            (cons 1 (encode-symbol symbol (right-branch tree))))))

  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))



(define rocktree (generate-huffman-tree '((a 2) (na 16) (boom  1)
                                          (sha 3) (get 2) (yip 9)
                                          (job 2) (wah 1))))

rocktree

(define rock-song '(get a job
                    sha na na na na na na na na
                    get a job
                    sha na na na na na na na na
                    wah yip yip yip yip yip yip yip yip yip
                    sha boom))

(define encoded-rock-song (encode rock-song rocktree))

encoded-rock-song
