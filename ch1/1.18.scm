;;EXERCISE 1.17

(define (fast-mult a b)
  (define (double x) (+ x x))
  (define (halve x) (/ x 2))
  (define (even? x) (= (remainder x 2) 0))
  (define (dec x) (- x 1))
  ; INVARIANT: a*b + c = a * b
  (define (fast-mult-iter a b c)
    (cond ((= b 0) c)
          ((even? b) (fast-mult-iter (double a) (halve b 2) c))
          (else      (fast-mult-iter a          (dec b) (+ c a)))))
  (fast-mult-iter a b 0))
