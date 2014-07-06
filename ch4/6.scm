;;; EXERCISE 4.6

;;; No IDEA why this won't work. When I evaluate
;;; 
;;;   (eval '(let ((a 4)) a) the-global-environment)
;;; 
;;; I get the error:
;;; 
;;;   The object 4 is not applicable.
;;;
;;; But when I evaluate:
;;;
;;;   (eval '(let->combination exp) the-global-environment)
;;;
;;; I get:
;;;
;;;   Value: 4
;;;
;;; WHY????
;;;
;;; No matter. This exercise taught me more about debugging with
;;; `mit-scheme' than any previous exercise ;)
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
	((let? exp) ((eval (let->combination exp) env)))
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
(define (let-tuples exp) (cadr exp))
(define (let-body exp) (caddr exp))
(define (tuple-variable tuple) (car tuple))
(define (tuple-expression tuple) (cadr tuple))

(define (let->combination exp)
  (let ((tuples (let-tuples exp)))
    (make-combination
     (list 'lambda (map tuple-variable tuples) (let-body exp))
     (map tuple-expression tuples))))

(define (make-combination a b)
  (append (list a) b))

