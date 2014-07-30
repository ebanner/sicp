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

;;; Using memoization
;;; 
(square (id 10))
=> 100
count
=> 1

;;; Without memoization
;;;
(square (id 10))
=> 100
count
=> 2

;;; `count' winds up having a value of 2 when memoization is not used
;;; because `(id 10)' is captured as a thunk and evaluated twice in
;;; the body of `square'. Since evaluating the body of `square'
;;; involves incrementing `count', `count' is incremented twice.
;;;
;;; With memoization, the first time the `(id 10)' thunk is forced, it
;;; increments `count', but caches the value of 10 as its result. So
;;; when its forced again (as the second argument in the body of
;;; `square'), its value is just 10.
;;;
;;; So memoizing thunks necessarily dictates any side effects in the
;;; expression the thunk captured only run once.
