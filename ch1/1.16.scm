;;EXERCISE 1.16

; Thanks to Eli Bendersky for this solution
(define (fast-expt b n)
  (define (square x) (* x x))
  (define (even? x) (= (remainder x 2) 0))
  (define (dec x ) (- x 1))
  (define (fast-expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-iter (square b) (/ n 2) a))
          (else      (fast-expt-iter b          (dec n) (* b a)))))
  (fast-expt-iter b n 1))
