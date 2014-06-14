;; EXERCISE 3.2

;: (define s (make-monitored sqrt))
;: (s 100)
;: (s 'how-many-calls?)

(define (make-monitored proc)
  (let ((how-many-calls 0))
    (define (dispatch message)
      (if (equal? message 'how-many-calls?)
	  how-many-calls
	  (begin
	    (set! how-many-calls (+ how-many-calls 1))
	    (proc message))))
    dispatch))
