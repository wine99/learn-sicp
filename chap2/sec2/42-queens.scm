(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))


(define empty-board '())
(define (adjoin-position new-row k rest-of-queens)
  (cons (list new-row k) rest-of-queens))

(define (safe? k positions)
  (define (same-row? a b) (= (car a) (car b)))
  (define (same-right-diagonal? a b)
    (= (- (car a) (cadr a))
       (- (car b) (cadr b))))
  (define (same-left-diagonal? a b)
    (= (+ (car a) (cadr a))
       (+ (car b) (cadr b))))
  (define (safe? this-queen rest-positions)
    (if (null? rest-positions)
        #t
        (and (not (same-row? this-queen (car rest-positions)))
             (not (same-right-diagonal? this-queen (car rest-positions)))
             (not (same-left-diagonal? this-queen (car rest-positions)))
             (safe? this-queen (cdr rest-positions)))))
  (safe? (car positions) (cdr positions)))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
          (lambda (positions) (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                     (adjoin-position new-row k rest-of-queens))
                   (enumerate-interval 1 board-size)))
            (queen-cols (- k 1))))))
  (queen-cols board-size))

; One solution to (queens 1),
; zero to (queens 2) and (queens 3),
; two to (queens 4),
; 92 to (queens 8).

(length (queens 1))
(length (queens 2))
(length (queens 3))
(length (queens 4))
(length (queens 8))
