;;; EXERCISE 3.17

(define (count-pairs p counted)
  (cond ((not (pair? p)) 0)
	((memq p counted) 0)
	(else (+ 1
		 (count-pairs (car p) (append p counted))
		 (count-pairs (cdr p) (append p counted))))))
