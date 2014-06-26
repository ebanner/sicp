;;; EXERCISE 3.60

;;; Credit to Eli Bendersky for solution.
(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
	       (add-streams (scale-stream s1 (stream-car s1))
			    (mul-series (stream-cdr s1) s2))))
