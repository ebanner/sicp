;;EXERCISE 1.21

(define (smallest-divisor n)
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  (define (divides? a b)
    (= (remainder b a) 0))
  (find-divisor n 2))

; 4 error> (smallest-divisor 199)
; ;Value: 199
; 
; 4 error> (smallest-divisor 1999)
; ;Value: 1999
; 
; 4 error> (smallest-divisor 19999)
; ;Value: 7
