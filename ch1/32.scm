;;EXERCISE 1.32
;: (accumulate combiner null-value term a next b)

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (accumulate combiner null-value term a next b)
  (define (accumulate-iter a total)
    (if (< b a)
        total
        (accumulate-iter (next a) (combiner total (term a)))))
  (accumulate-iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))
