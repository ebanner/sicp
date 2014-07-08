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

;;; (for <bindings> <test> <update> <body>)
;;;
;;; e.g.
;;;
;;;   (for ((i random) (j random)) (prime? (+ i j)) ((define i (random)) (define j random))
;;;     (display (+ i j)))
;;; 
;; (define (for? exp) (tagged-list? exp 'for))
;; (define (for-bindings exp) (cadr exp))
;; (define (first-binding binding) (car bindings))
;; (define (rest-binding binding) (cdr bindings))
;; (define (for-test exp) (caddr exp))
;; (define (for-updates exp) (cadddr exp))
;; (define (for-body exp) (cddddr exp))
;; (define (eval-for exp env)
;;   (let ((bindings (for-bindings exp))
;; 	(test (for-test exp))
;; 	(update (for-update exp))
;; 	(body (for-body exp)))))

;;; (while <condition> <body>)
;;;
;;; e.g.
;;;
;;; (while (< i 10) (display i))
;;;
(define (while? exp) (tagged-list? exp 'while))
(define (while-condition exp) (cadr exp))
(define (while-body exp) (cddr exp))
(define (eval-while exp env)
  (define (while-iter)
    (let ((condition (while-condition exp))
	  (body (while-body exp)))
      (cond ((true? (eval condition env))
	     (eval-sequence body env)
	     (while-iter))
	    (else 'done))))
  (while-iter))
