;;; EXERCISE 4.5

(define (expand-clauses clauses)
  (if (null? clauses)
      'false                          ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (cond ((cond-else-clause? first)
	       (if (null? rest)
		   (sequence->exp (cond-actions first))
		   (error "ELSE clause isn't last -- COND->IF"
			  clauses)))
	      ((rocket-clause? first)
	       (make-if (cond-predicate first)
			(make-procedure-application (sequence->exp (cdr (cond-actions first)))
						    (cond-predicate first))
			(expand-clauses rest)))
	      (else
	       (make-if (cond-predicate first)
			(sequence->exp (cond-actions first))
			(expand-clauses rest)))))))

(define (make-procedure-application proc arg)
  (list proc arg))

(define (rocket-clause? clause)
  (equal? (car (cond-actions clause)) '=>))
