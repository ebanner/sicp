;;; EXERCISE 4.3

;;; Make sure you load ch2support.scm (for `put' and `get') as well as
;;; ch4-mceval.scm (for all the helper functions not defined here)!

(define (eval exp env)
  (define (eval-typed-exp exp env)
    (let ((eval-proc (get (car exp) 'eval)))
      (if (false? eval-proc)
	  (error "Unknown expression type -- EVAL" exp)
	  (eval-proc exp env))))
  (cond ((self-evaluating? exp) exp)	; No type
        ((variable? exp) (lookup-variable-value exp env)) ; No type
        (else (eval-typed-exp exp env)))) ; Type

;;; Procedures with no data-directivity

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

(define (variable? exp) (symbol? exp))

;;; Procedures with data-directivity

(define (install-quote-special-form)
  (define (text-of-quotation exp) (cadr exp))
  ;; Interface to `eval'
  (put 'quote 'eval (lambda (exp env) (text-of-quotation exp))))

(define (install-set!-special-form)
  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))
  (define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
			 (eval (assignment-value exp) env)
			 env)
    'ok)
  ;; Interface to `eval'
  (put 'set! 'eval eval-assignment))

(define (install-define-special-form)
  (define (definition-variable exp)
    (if (symbol? (cadr exp))
	(cadr exp)
	(caadr exp)))
  (define (definition-value exp)
    (if (symbol? (cadr exp))
	(caddr exp)
	(make-lambda (cdadr exp)
		     (cddr exp))))
  (define (eval-definition exp env)
    (define-variable! (definition-variable exp)
      (eval (definition-value exp) env)
      env)
    'ok)
  ;; Interface to `eval'
  (put 'define 'eval eval-definition)
  )

(define (install-lambda-special-form)
  (define (lambda-parameters exp) (cadr exp))
  (define (lambda-body exp) (cddr exp))
  (define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))
  (define (make-procedure parameters body env)
    (list 'procedure parameters body env))
  ;; Interface to `eval'
  (put 'lambda 'eval (lambda (exp env)
		       (make-procedure (lambda-parameters exp)
				       (lambda-body exp)
				       env))))

(define (install-if-special-form)
  (define (if-predicate exp) (cadr exp))
  (define (if-consequent exp) (caddr exp))
  (define (if-alternative exp)
    (if (not (null? (cdddr exp)))
	(cadddr exp)
	'false))
  (define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))
  (define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
	(eval (if-consequent exp) env)
	(eval (if-alternative exp) env)))
  ;; Interface to `eval'
  (put 'if 'eval eval-if)
  ;; Export `make-if so cond can use it
  (put 'if 'make-if make-if))


(define (install-begin-special-form)
  (define (begin-actions exp) (cdr exp))
  (define (last-exp? seq) (null? (cdr seq)))
  (define (first-exp seq) (car seq))
  (define (rest-exps seq) (cdr seq))
  (define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp exps) env))
	  (else (eval (first-exp exps) env)
		(eval-sequence (rest-exps exps) env))))
  ;; Interface to `eval'
  (put 'begin 'eval (lambda (exp env)
		      (eval-sequence (begin-actions exp) env))))

(define (install-call-special-form)
  (define (tagged-list? exp tag)
    (if (pair? exp)
	(eq? (car exp) tag)
	false))
  (define (operator exp) (cadr exp))
  (define (operands exp) (cddr exp))
  (define (no-operands? ops) (null? ops))
  (define (first-operand ops) (car ops))
  (define (rest-operands ops) (cdr ops))
  (define (compound-procedure? p)
    (tagged-list? p 'procedure))
  (define (procedure-parameters p) (cadr p))
  (define (procedure-body p) (caddr p))
  (define (procedure-environment p) (cadddr p))
  (define (list-of-values exps env)
    (if (no-operands? exps)
	'()
	(cons (eval (first-operand exps) env)
	      (list-of-values (rest-operands exps) env))))
  (define (apply procedure arguments)
    (cond ((primitive-procedure? procedure)
	   (apply-primitive-procedure procedure arguments))
	  ((compound-procedure? procedure)
	   (eval-sequence
	    (procedure-body procedure)
	    (extend-environment
             (procedure-parameters procedure)
             arguments
             (procedure-environment procedure))))
	  (else
	   (error
	    "Unknown procedure type -- APPLY" procedure))))
  ;; Interface to `eval'
  (put 'call 'eval (lambda (exp env)
		     (apply (eval (operator exp) env)
			    (list-of-values (operands exp) env)))))

(define (install-cond-special-form)
  (define (cond-clauses exp) (cdr exp))
  (define (cond-else-clause? clause)
    (eq? (cond-predicate clause) 'else))
  (define (cond-predicate clause) (car clause))
  (define (cond-actions clause) (cdr clause))
  (define (cond->if exp)
    (expand-clauses (cond-clauses exp)))
  (define (sequence->exp seq)
    (cond ((null? seq) seq)
	  ((last-exp? seq) (first-exp seq))
	  (else (make-begin seq))))
  (define (make-begin seq) (cons 'begin seq))
  (define (expand-clauses clauses)
    (if (null? clauses)
	'false                          ; no else clause
	(let ((first (car clauses))
	      (rest (cdr clauses)))
	  (if (cond-else-clause? first)
	      (if (null? rest)
		  (sequence->exp (cond-actions first))
		  (error "ELSE clause isn't last -- COND->IF"
			 clauses))
	      (make-if (cond-predicate first)
		       (sequence->exp (cond-actions first))
		       (expand-clauses rest))))))
  ;; Interface to `eval'
  (put 'cond 'eval (lambda (exp env) (eval (cond->if exp) env))))

(install-quote-special-form)
(install-set!-special-form)
(install-define-special-form)
(install-lambda-special-form)
(install-if-special-form)
(install-begin-special-form)
(install-call-special-form)
(install-cond-special-form)
