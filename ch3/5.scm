;;; EXERCISE 3.5

(define (estimate-integral trials P x1 x2 y1 y2)
  (define (integral-test)
    (let ((x (random-in-range x1 x2))
	  (y (random-in-range y1 y2)))
      (P x y)))
  (define (area p q r s) (+ (* p r) (* q s)))
  (define (random-in-range low high)
    (let ((range (- high low)))
      (+ low (random range))))
  (define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
      (cond ((= trials-remaining 0)
	     (/ trials-passed trials))
	    ((experiment)
	     (iter (- trials-remaining 1) (+ trials-passed 1)))
	    (else
	     (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))
  (* (area x1 y1 x2 y2)
     (monte-carlo trials integral-test)))

(define (predicate x y)
  (define (square x) (* x x))
  (<= (+ (square (- x 5)) (square (- y 7)))
      (square 3)))

