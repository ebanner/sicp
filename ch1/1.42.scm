;;EXERCISE 1.42

;: ((compose square inc) 6)

(define (compose f g)
  (lambda (x) (f (g x))))

