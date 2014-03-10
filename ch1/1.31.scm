;;EXERCISE 1.31

(define (product term i next n)
  (if (< n i)
      1
      (* (term i)
         (product term (next i) next n))))

(define (product term i next n)
  (define (product-iter i total)
  (if (< n i)
      total
      (product-iter (next i) (* total (term i)))))
  (product-iter i 1))

(define (factorial n)
  (product (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

(define (pi n)
  (define (inc x) (+ x 1))
  (define (numer-term k)
    (if (even? k)
        (+ k 2)
        (+ k 3)))
  (define (denom-term k)
    (if (even? k)
        (+ k 3)
        (+ k 2)))
  (* 4.0
     (/ (product numer-term 0 inc n)
        (product denom-term 0 inc n))))
     
