;;EXERCISE 1.41

;: (((double (double double)) inc) 5)

(define (double f)
  (lambda (x) (f (f x))))
