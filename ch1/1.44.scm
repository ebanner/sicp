;;EXERCISE 1.44

(define (smooth f)
  (define dx 0.0001)
  (define (average x y z)
    (/ (+ x y z)
       3))
  (lambda (x) (average (f (- x dx)) (f x) (f (+ x dx)))))

(define (n-smoothed f n)
  (repeated smooth n))
  
(define (repeated f n)
  (define (compose f g)
    (lambda (x) (f (g x))))
  (define (loop i)
    (if (= i n)
        (lambda (x) x)
        (compose f (loop (+ i 1)))))
  (loop 0))
