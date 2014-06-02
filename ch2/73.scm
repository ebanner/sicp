;; EXERCISE 2.73
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (else (error "unknown expression type -- DERIV" exp))))

;; It's been a while, but it's good to be back :)

;; a. Instead of doing a dispatch on type, we insert the functions for
;; each different type of expression into a table where we do a lookup
;; for that function. Ergo each expression knows how to evaluate
;; itself by looking in this table.
;;
;; We cannot assimilate `number?' and `same-variable?' into the table
;; because number contains no type information. Said another way, we
;; cannot strip off the car of an expression that contains a number
;; and pass it onto the function that knows how to differentiate a
;; number. Likewise we cannot assimilate `same-variable?' into the
;; table because a variable has no type information (it's just an
;; atom).

;; b. 

(define (sum-deriv exp var)
  (make-sum (deriv (car exp) var)
	    (deriv (cdr exp) var)))

(put 'deriv '+ sum-deriv)

(define (product-deriv exp var)
  (make-sum
   (make-product (car exp) (deriv (cdr exp) var))
   (make-product (deriv (car exp) var) (cdr exp))))

(put 'deriv '* product-deriv)

;;; c. We'll do exponents, shall we?

(define (exp-deriv exp var)
  (let ((base (car exp))
	(pow  (cdr exp)))
    (make-product pow
		  (make-exp base (make-sum pow (- 1)))
		  (deriv base var))))

(put 'deriv '** exp-deriv)

;;; d. The only thing that has to change is the code that inserts the
;;; functions into the table
