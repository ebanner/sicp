;;; EXERCISE 4.20

;;; a.

(define (make-let tuples body) (cons 'let (cons tuples body)))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
	((let? exp) (eval (let->combination exp) env))
	((letrec? exp) (eval (letrec->let exp) env))
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

(define (letrec? exp) (tagged-list? exp 'letrec))
(define (make-let-binding var val) (list var val))
(define (binding-variable binding) (car binding))
(define (binding-value binding) (cadr binding))

;;; 
;;; (letrec->let '(letrec ((<b1> <v1>)
;;;                        (<b2> <v2>)
;;;                             .
;;;                             .
;;;                             .
;;;                        (<bn> <vn>))
;;;                 <body>))
;;;
;;; => '(let ((<b1> '*unassigned*)
;;;           (<b2> '*unassigned*)
;;;                .
;;;                .
;;;                .
;;;           (<bn> '*unassigned*))
;;;       (set! <b1> <v1>)
;;;       (set! <b2> <v2>)
;;;                .
;;;                .
;;;                .
;;;       (set! <b3> <v3>)
;;;       <body>)
;;;                        
(define (letrec->let exp)
  ;; 
  ;; (let-bindings->*unassigned* '((a 4)
  ;;                               (b 5)
  ;;                               (c 6)))
  ;;
  ;; => '((a '*unassigned*)
  ;;   	  (b '*unassigned*)
  ;;   	  (c '*unassigned*))
  ;;   
  (define (let-bindings->*unassigned* bindings)
    (if (null? bindings)
	'()
	(let ((first-binding (car bindings))
	      (rest-bindings (cdr bindings)))
	  (cons (make-let-binding (car first-binding) ''*unassigned*)
		(let-bindings->*unassigned* rest-bindings)))))
  ;;
  ;; (let-bindings->values '((a 4)  
  ;;			     (b 5)  
  ;;			     (c 6)))
  ;;
  ;; => '((set! a 4)
  ;;      (set! b 5)
  ;;      (set! c 6))
  ;;
  (define (let-bindings->values bindings)
    (if (null? bindings)
	'()
	(let ((first-binding (car bindings))
	      (rest-bindings (cdr bindings)))
	  (cons (list 'set!
		      (binding-variable first-binding)
		      (binding-value first-binding))
		(let-bindings->values rest-bindings)))))
  (make-let (let-bindings->*unassigned* (let-tuples exp))
	    (append (let-bindings->values (let-tuples exp))
		    (let-body exp))))

