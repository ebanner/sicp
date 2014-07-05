;;; EXERCISE 4.1

;;; Left to Right evaluation
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((left-most-value		; Evaluate the left-most argument
	     (eval (first-operand exps) env)))
	(cons left-most-value
	      (list-of-values (rest-operands exps) env)))))  ; Then evaluate the rest of the arguments

;;; Right to Left evaluation
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((right-most-values		; Evaluate the rest of the arguments
	     (list-of-values (rest-operands exps) env)))
	(cons (eval (first-operand exps) env) ; Then evaluate the left-most argument
	      right-most-values))))
