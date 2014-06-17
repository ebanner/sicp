;;; EXERCISE 3.18

;;; Thanks for the inspiration Dr. Ladd ;)
(define (loop? p1 p2 l)
  (cond ((or (null? p1) (null? p2)) #f)
	((eq? p1 p2) #t)
	(else (loop? (cdr p1) (cddr p2)))))
