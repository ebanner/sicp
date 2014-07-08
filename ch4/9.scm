;;; EXERCISE 4.9

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
	((let? exp) (eval (let->combination exp) env))
	((let*? exp) (eval (let*->nested-lets exp) env))
	((do? exp) (eval-do exp env))
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

;;; (do (e1 e2 ... en) while f)
(define (do? exp) (tagged-list? exp 'do))
(define (do-actions exp) (cadr exp))
(define (do-while-test exp) (cadddr exp))
(define (eval-do exp env)
  (define (do-iter exp)
    (cond ((true? (eval (do-while-test exp) env)) ; Is the do-test true?
	   (eval-sequence (do-actions exp) env)	; If so, evaluate the actions
	   (do-iter exp))		; Then go back around again
	  (else 'done)))
  (eval-sequence (do-actions exp) env)	; Evaluate the actions at least once
  (do-iter exp))
