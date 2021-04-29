; Wrong solution of count-pairs

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

; Some special list structures made up of exactly three pairs
; being applied to this procedure, will have the answer of either
; 3, 4, 5, 7 or never return at all.
