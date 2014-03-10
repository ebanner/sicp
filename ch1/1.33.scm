;;EXERCISE 1.33

(define (filtered-accumulate combiner null-value pred term a next b)
  (if (> a b)
      null-value
      (combiner (if (pred a) (term a) null-value)
                (filtered-accumulate combiner
                                     null-value
                                     pred
                                     term
                                     (next a)
                                     next
                                     b))))

(define (filtered-accumulate combiner null-value pred term a next b)
  (define (filtered-accumulate-iter a total)
    (if (< b a)
        total
        (filtered-accumulate-iter
         (next a)
         (if (pred a) (combiner total (term a)) total))))
  (filtered-accumulate-iter a null-value))

; Prime procedures
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))
