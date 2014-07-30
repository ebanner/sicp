;;; EXERCISE 4.29

;;; Here is a procedure that runs much more slowly when memoization is
;;; not used. It runs much slower because the value to find it turned
;;; into a thunk and every time we check to see if the first element
;;; in the list is equal to the value, we have to evaluate the
;;; expression that represents the value again.
;;;
;;; With memoization, the expression passed as the `val' parameter
;;; will only be evaluated once when its compared to the car of `list'.
;;;
(define (find list val)
  (define (find-iter l)
    (cond ((null? l) false)
	  ((equal? (car l) val) true)
	  (else (find-iter (cdr l)))))
  (find-iter list))

(find huge-list (exponential-fibonacci-procedure googolplex))
