;;; EXERCISE 3.61

(define (invert-unit-series S)
  (cons-stream 1 (scale-stream
		  (mul-stream (stream-cdr S) (invert-unit-series S))
		  -1)
