;;; EXERCISE 2.79

(define (equ? n1 n2)
  (apply-generic 'equ? n1 n2))

;;; Add this to the scheme-number package
(put 'equ? '(scheme-number scheme-number) (lambda (x y) (= x y)))

;;; Add this to the rational-number package. Assume rational numbers
;;; are already in lowest terms
(put 'equ? '(rational rational) (lambda (x y)
				  (and (= (numer x) (number y))
				       (= (denom x) (denom y)))))

;;; Add *this* to the complex-number package
(put 'equ '(complex complex) (lambda (z w)
			       (and (= (x-part z) (x-part w))
				    (= (y-part z) (y-part w)))))
