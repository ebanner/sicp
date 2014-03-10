;;EXERCISE 1.46

(define (iterate-improve good-enough? improve)
  (define (iterate-improve-iter guess)
    (if (good-enough? guess)
        guess
        (iterate-improve-iter (improve guess))))
  (iterate-improve-iter 1.0))

(define (average-damp f)
  (define (average x y) (/ (+ x y) 2))
  (lambda (x) (average x (f x))))

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.01))
  (define (improve guess)
    ((average-damp (lambda (y) (/ x y))) guess))
  (iterate-improve good-enough? improve))

;; Fixed points
(define (fixed-point f)
  (define (good-enough? guess)
    (< (abs (- guess (f guess))) 0.00001))
  (define (improve guess)
    (f guess))
  (iterate-improve good-enough? improve))
