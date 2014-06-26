;;; EXERCISE 3.62

(define (div-series s1 s2)
  (if (equal? 0 (stream-car s2))
      (error "Can't divide by a power series with a zero constant term")
      (mul-series s1 (invert-unit-series s2))))
