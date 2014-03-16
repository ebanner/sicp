;; EXERCISE 2.40

(define (unique-pairs n)
  (flatmap (lambda (i)
         (map (lambda (j) (list j i))
              (enumerate-interval 1 (- i 1))))
       (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))

; Wrote a little predicate procedure for determining if a number is
; prime because there's no definition of prime? in the the provided
; ch2 code.
(define (prime? n)
  (null?
   (filter (lambda (x) (eq? (modulo n x) 0))
           (enumerate-interval 2 (- n 1))))))
