;;; EXERCISE 4.7

;;; `eval' with an added `let*?' syntactical construct
;;; 
;;; It is perfectly sufficient to expand `let*' in terms of nested
;;; `let' expressions.
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
	((let? exp) (eval (let->combination exp) env))
	((let*? exp) (eval (let*->nested-lets exp) env))
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

(define (let*? exp) (tagged-list? exp 'let*))
(define (let*-tuples exp) (cadr exp))

;;; Package the let body into a `begin'
(define (package-let*-body exp) (sequence->exp (cddr exp)))

;;; Get the let body that's already been packaged into `begin'
(define (packaged-let*-body exp) (caddr exp))

(define (first-tuple tuples) (list (car tuples)))
(define (rest-tuples tuples) (cdr tuples))
(define (make-let tuples body) (list 'let tuples body))
(define (make-let* tuples body) (list 'let* tuples body))

;;; We need to package up the let* body into something we can pass to
;;; a function because we're using recursion
(define (let*->nested-lets exp)
  (let*->nested-lets-loop (make-let* (let*-tuples exp) (package-let*-body exp))))

(define (let*->nested-lets-loop exp)
  (let ((tuples (let*-tuples exp))
	(body (packaged-let*-body exp)))
    (if (null? tuples)
	body			  ; No more tuples. It's just the packaged body
	(make-let (first-tuple tuples)
		  (let*->nested-lets-loop (make-let* (rest-tuples tuples) body))))))
