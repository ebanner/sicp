;;; EXERCISE 3.29

;;; ~(~A * ~B) = ~(~A) + ~(~B) = A + B by DeMorgan's Laws 
(define (or-gate a b f)
  (let ((c (make-wire))
	(d (make-wire))
	(e (make-wire)))
    (invertor a c)
    (invertor b d)
    (and-gate c d e)
    (invertor e f)))
