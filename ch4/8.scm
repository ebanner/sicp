;;; EXERCISE 4.8

;;; What we want to do is transform
;;;
;;;   (let <var> <bindings> <body>)
;;;
;;; into
;;;
;;;   (let ((<var> (lambda (formals <bindings>) <body>)))
;;;     (<var> (exps <bindings>)))
;;;
;;; For example,
;;; 
;;;   (define (fib n)
;;;     (let fib-iter ((a 1)
;;;                    (b 0)
;;;                    (count n))
;;;       (if (= count 0)
;;;           b
;;;           (fib-iter (+ a b) a (- count 1)))))
;;;
;;; becomes
;;;
;;;   (let ((fib-iter (lambda (a b count)
;;;                     (if (= count 0)
;;;                         b
;;;                         (fib-iter (+ a b) a (- count 1))))))
;;;     (fib-iter (1 0 n)))
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

(define (let? exp) (tagged-list? exp 'let))
(define (regular-let? exp) (pair? (cadr exp)))
(define (let-tuples exp) (cadr exp))
(define (let-body exp) (cddr exp))
(define (tuple-variable tuple) (car tuple))
(define (tuple-expression tuple) (cadr tuple))
(define (named-let? exp) (symbol? (cadr exp)))
(define (named-let-var exp) (cadr exp))
(define (named-let-bindings exp) (caddr exp))
(define (named-let-body exp) (cdddr exp))
(define (make-let tuples body) (list 'let tuples body))

(define (let->combination exp)
  (cond ((named-let? exp)
	 (let ((var (named-let-var exp))
	       (bindings (named-let-bindings exp))
	       (body (named-let-body exp)))
	   (make-let (list var (make-lambda (map tuple-variable bindings) body))
		     (list var (map tuple-expression bindings)))))
	((regular-let? exp)
	 (let ((tuples (let-tuples exp)))
	   (cons
	    (make-lambda (map tuple-variable tuples) (let-body exp))
	    (map tuple-expression tuples))))
	(else (error "INVALID LET FORM"))))
