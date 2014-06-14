;;; EXERCISE 3.4

(define (make-account balance password)
  (define retry-attempts 7)		; Maximum password attempts
  (define (call-the-cops) (begin
			    (display "WOO WOO... The cops are coming!!!")
			    (newline)
			    die))
  (define (die _) '())
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch guess m)
    (cond ((not (equal? guess password))
	   (cond ((equal? retry-attempts 0) (call-the-cops))
		 (else
		  (set! retry-attempts (- retry-attempts 1))
		  (display "Incorrect password. Retry attempts: ")
		  (display retry-attempts)
		  (newline)
		  die)))
	  (else (cond ((eq? m 'withdraw) withdraw)
		      ((eq? m 'deposit) deposit)
		      (else (error "Unknown request -- MAKE-ACCOUNT"
				   m))))))
  dispatch)
