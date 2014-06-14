;;; EXERCISE 2.87

;;; Note: If we happen to be determining if a polynomial with a
;;; polynomial as the coefficient of its first term, then we are going
;;; to recursively call this procedure again. Eventually we have to
;;; get down to something that isn't a polynomial, right? Then we'll
;;; be able to determine whether the initial polynomial is zero or
;;; not... You see you're always relying on a simpler problem to be
;;; solved, even if it's the same problem you're working on (only the
;;; first coefficient vs. all of the coefficients).
(define (=z? poly)
  (if (equal? (the-empty-term-list) poly)
      #t
      (and (=zero? (coeff (first-term poly))) ; generic `=zero?'
	   (=z? (rest-terms poly)))))

;;; Install it into the `polynomial' package
(put '=zero? '(polynomial) =z?)
