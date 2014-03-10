;;EXERCISE 1.7

; The good-enough? procedure in its current incarnation is
; insufficient because it deems a guess good enough when the square of
; the guess is within 0.001 of the number we're trying to find the
; square root of. Here's an example of this current implementation
; failing hard for small numbers: ;
; (sqrt-iter 1.0 10^-n)
; 
; Once our guess gets to about 0.03, we're going to stop because we're
; within 0.001 of 10-n, but in reality the square root of 10^-n is
; 10^-n/2, which is n/2 - 2 orders of magnitude smaller than 0.03! So
; this is going to work very badly for large n values!
;
; Heres a new good-enough? procedure implemented in the manner
; suggested by Abelson & Sussman.

;; Block-structured
(define (sqrt x)
  (define (average x y)
    (/ (+ x y)
       2))
  (define (good-enough? guess x)
    (define ratio /)
    (define (percent n) (/ n 100))
    (let ((change (abs (- guess
                          (/ (+ guess
                                (/ x guess)
                             )
                             2
                          )
                       )
                  )
          ))
          (< (ratio change x) (percent 1))
    )
  )
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))

