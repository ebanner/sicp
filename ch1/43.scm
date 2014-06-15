;;EXERCISE 1.43

;: ((repeated square 2) 5)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (loop i)
    (if (= i n)
        (lambda (x) x)
        (compose f (loop (+ i 1)))))
  (loop 0))
