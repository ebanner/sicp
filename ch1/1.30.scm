;;EXERCISE 1.30

(define (sum term a next b)
  (define (sum-iter a total)
    (if (< b a)
        total
        (sum-iter (next a) (+ total (term a)))))
  (sum-iter a 0))

