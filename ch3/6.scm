;;; EXERCISE 3.6

(define (randomness)
  (let ((seed 0))
    (define (generate) (begin
			 (set! seed (+ seed 1))
			 seed))
    (define (reset s) (set! seed s))
    (define (dispatch message)
      (cond ((equal? message 'generate) (generate))
	    ((equal? message 'reset) reset)))
    dispatch))
