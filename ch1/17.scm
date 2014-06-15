;;EXERCISE 1.17

(define (fast-mult a b)
  (define (double x) (+ x x))
  (define (halve x) (/ x 2))
  (define (even? x) (= (remainder x 2) 0))
  (define (dec x) (- x 1))
  (cond ((= b 0) 0)
        ((= b 1) a)
        ((even? b) (double (fast-mult a (halve b))))
        (else      (+ a (fast-mult a (dec b))))))
