;;; EXERCISE 4.26

;;; unless
(define (unless->if if-exp)
  (make-if (unless-predicate exp)
	   (unless-consequent exp)
	   (unless-alternative exp)))

;;; Having `unless' be a procedure might be interesting if you want to
;;; use `unless' in a higher-order-procedure. For example, if you
;;; wanted to implement a procedure that flipped a coin and evaluates
;;; to the result, then you could do that:
(define (coin-flip)
  (define (cf if-or-unless)
    (if-or-unless (equal? 1 1)
		  'H
		  'T))
  (let ((one-or-zero (give-me-a-one-or-a-zero)))
    (if (equal? one-or-zero 'one)
	(cf if)
	(cf unless))))			; Ha!
