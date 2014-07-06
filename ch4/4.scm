;;; EXERCISE 4.1

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
	((and? exp) (eval-and (and-operands exp) env))
	((or? exp) (eval-or (or-operands exp) env))	
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(define (and? exp) (tagged-list? exp 'and))
(define (and-operands exp) (cdr exp))

(define (eval-and exp env)
  (define (first-and-operand exp) (car exp))
  (define (rest-and-operands exp) (cdr exp))
  (define (eval-and-iter exp env)
    (if (null? (rest-and-operands exp))	; Only one element remaining
	(eval (first-and-operand exp) env)	; Return that element
	(let ((hope (eval (first-and-operand exp) env))) ; More elements remaining
	  (if (true? hope)
	      (eval-and-iter (rest-and-operands exp) env)
	      false))))
  (if (null? exp)
      true
      (eval-and-iter exp env)))

(define (or? exp) (tagged-list? exp 'or))
(define (or-operands exp) (cdr exp))

(define (eval-or exp env)
  (define (first-or-operand exp) (car exp))
  (define (rest-or-operands exp) (cdr exp))
  (if (null? exp)
      false
      (let ((equalizer (eval (first-or-operand exp) env)))
	(if (true? equalizer)
	    equalizer
	    (eval-or (rest-or-operands exp) env)))))
