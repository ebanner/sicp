;;; EXERCISE 59.scm

; a.
(define (integrate-series s)
  (mul-streams s
	       (map-stream (lambda (x) (/ 1 x)) integers)))

; b.
(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

; c
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
