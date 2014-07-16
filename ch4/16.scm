;;; EXERCISE 4.16

;;; a.
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))	; Found the variable
	     (if (eq? (car vals) '*unassigned*)	; Check to see if it's unassigned
		 (error "Unassigned variable" var)
		 (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;;; b.
(define (scan-out body-exp)
  (define (scan-out-bindings exp)
    (let ((first-exp (car exp)))
      (if (definition? first-exp)
	  (cons (list (definition-variable first-exp) ''*unassigned*)
		(scan-out-bindings (cdr exp)))
	  '())))
  (define (scan-out-set!s exp)
    (let ((first-exp (car exp)))
      (if (definition? first-exp)
	  (cons (list 'set!
		      (definition-variable first-exp)
		      (definition-value first-exp))
		(scan-out-set!s (cdr exp)))
	  exp)))
  (if (definition? (car body-exp))
      (list (make-let (scan-out-bindings body-exp)
		      (scan-out-set!s body-exp)))
      body-exp))		       ; Othewise just return the body

(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out body) env))

(define (make-let tuples body) (cons 'let (cons tuples body)))
