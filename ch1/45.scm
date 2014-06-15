;;EXERCISE 1.43

;: ((repeated square 2) 5)

(define (repeated f n)
  (define (compose f g)
    (lambda (x) (f (g x))))
  (define (loop i)
    (if (= i n)
        (lambda (x) x)
        (compose f (loop (+ i 1)))))
  (loop 0))

(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0)))

(define (cubrt x)
  (fixed-point-of-transform (lambda (y) (/ x (square y)))
                            average-damp
                            1.0))

(define (4throot x)
  (fixed-point-of-transform (lambda (y) (/ x (cube y)))
                            (repeated average-damp 2)
                            1.0))

(define (5throot x)
  (define (hyper-cube x) (* x x x x x))
  (fixed-point-of-transform (lambda (y) (/ x (hyper-cube y)))
                            (repeated average-damp 2)
                            1.0))

(define (6throot x)
  (fixed-point-of-transform (lambda (y) (/ x (expt y 5)))
                            (repeated average-damp 2)
                            1.0))

; Eh, if we apply average damp 1/2 of the times of the root we're
; trying to find, we'll call that good enough
(define (nth-root root x)
  (fixed-point-of-transform (lambda (y) (/ x (expt y (- root 1))))
                            (repeated average-damp (integer-floor root 2))
                            1.0))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average x y)
  (/ (+ x y)
     2))

(define (fixed-point-of-transform f transform guess)
  (fixed-point (transform f) guess))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
