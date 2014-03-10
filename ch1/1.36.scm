;;EXERCISE 1.36

(define (fixed-point f first-guess)
  (define tolerance 1)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (f x)
  (/ (log 1000) x))
