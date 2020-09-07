#lang sicp

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


; GCD(206,40) = GCD(40,6)
;             = GCD(6,4)
;             = GCD(4,2)
;             = GCD(2,0) = 2

; ex1.20
; Using the substitution method (for normal order),
; illustrate the process generated in evaluating (gcd 206 40)
; and indicate the remainder operations that are actually performed.
; How many remainder operations are actually performed
; in the normal-order evaluation of (gcd 206 40)?


; SOLUTION http://community.schemewiki.org/?sicp-ex-1.20

; Let b_i be the value of b at the n'th invocation of gcd(a,b).
; Let b(i) be the count of remainder procedure needed to calculate b_i.
; Similarly, define a_i and a(i). It is easy to check that

; 1. a_i=b_(i-1) and thus a(i)=b(i-1).
; 2. b(i+1) = a(i) + b(i) + 1 = b(i-1) + b(i) + 1 because b_(i+1) = a_i mod b_i

; Based on my own derivation, R should be
; b(1)+b(2)+...+b(n)+b(n-1) with b(1)=0, b(2)=1 and b(n)=b(n-1)+b(n-2)+1
; Obviously we could get
; b(k) = fib(k+1) - 1

; So, R(n) = SUM(i from 1 to n, fib(i+1)- 1) + fib(n) -1

; R(1) = 0

; R(2) = 1

; R(3) = 4

; R(4) = 9

; R(5) = 18