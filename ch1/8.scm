;;EXERCISE 1.8

(define (cubrt x)
  (define (cube x) (* x x x))
  (define (good-enough? guess x)
    (< (abs (- (cube guess) x)) 0.001))
  (define (improve guess x)
    (/ (+ (/ x
             (square guess))
          (* 2 guess))
       3))
  (define (cubrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (cubrt-iter (improve guess x) x)))
  (cubrt-iter 1.0 x))
