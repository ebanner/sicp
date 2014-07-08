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
	((while? exp) (eval-while exp env))
	((for? exp) (eval (for->let-while exp) env))
	((until? exp) (eval (until->while exp) env))
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

;;; 
;;; (do <actions> while <test>)
;;;
;;; e.g.
;;;
;;;   (do ((display i) (define i (inc i))) while (< i 10))
;;; 
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

;;; 
;;; (while <condition> <body>)
;;;
;;; e.g.
;;;
;;; (while (< i 10) (display i))
;;;
(define (while? exp) (tagged-list? exp 'while))
(define (while-condition exp) (cadr exp))
(define (while-body exp) (cddr exp))
(define (make-while test body) (cons 'while (cons test body)))
(define (eval-while exp env)
  (define (while-iter)
    (let ((condition (while-condition exp))
	  (body (while-body exp)))
      (cond ((true? (eval condition env))
	     (eval-sequence body env)
	     (while-iter))
	    (else 'done))))
  (while-iter))

;;; 
;;; (for <bindings> <test> <updates> <body>)
;;;
;;; e.g.
;;;
;;;   (for ((i 1)) (< i 5) ((define i (+ i 1)))
;;;     (display i))
;;;
;;; We'll implement this as a derived expression. Thus, a `for' becomes:
;;;
;;;   (let <bindings>
;;;     (while <test> <body> <update>))
;;;
;;; Hence
;;;
;;;   (let ((i 1))
;;;     (while (< i 5) (display i) (define i (+ i 1))))
;;;     
(define (for? exp) (tagged-list? exp 'for))
(define (for-bindings exp) (cadr exp))
(define (for-test exp) (caddr exp))
(define (for-updates exp) (cadddr exp))
(define (for-body exp) (cddddr exp))
(define (for->let-while exp)
  (let ((bindings (for-bindings exp))
	(test (for-test exp))
	(updates (for-updates exp))
	(body (for-body exp)))
    (make-let bindings
	      (make-while test (append body updates)))))

;;;
;;; (until <condition> do <body>)
;;;
;;; We will implement this as a derived expression. It will be become:
;;;
;;; (while (not <condition>) <body>)
(define (until? exp) (tagged-list? exp 'until))
(define (until-condition exp) (cadr exp))
(define (until-body exp) (cdddr exp))
(define (until->while exp)
  (let ((condition (until-condition exp))
	(body (until-body exp)))
    (make-while (list 'not condition)
		body)))
