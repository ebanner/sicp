;;; EXERCISE 3.7

(define (make-account balance password)
  (let ((password-list (list password)))
    (define (withdraw amount)
      (if (>= balance amount)
	  (begin (set! balance (- balance amount))
		 balance)
	  "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (add-password password)
      (set! password-list (cons password password-list)))
    (define (dispatch guess m)
      (if (not (memq guess password-list))
	  (error "Invalid password")
	  (cond ((equal? m 'withdraw) withdraw)
		((equal? m 'deposit) deposit)
		((equal? m 'verify) #t)
		((equal? m 'add-password) add-password)
		(else (error "Unknown request -- MAKE-ACCOUNT"
			     m)))))
    dispatch))

(define (make-joint account password new-password)
  (begin
    ((account password 'add-password) new-password)
    account))
