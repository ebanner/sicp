;;; EXERCISE 3.55

;;; This one took a lot of thinking... :)
(define (partial-sum s)
  (define p-sum
    (cons-stream (stream-car s)
		 (add-streams (stream-cdr s)
			      p-sum)))
  p-sum)

