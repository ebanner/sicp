;;; EXERCISE 2.88

(define (negate obj) (apply-generic 'negate obj))

(define (negate-polynomial poly)
  (if (equal? (the-empty-term-list) poly)
      0
      (mul (make-poly 'e (make-term 0 -1))
	   poly)))

(define (subtract-poly p1 p2)
  (add-poly p1 (negate-poly p2)))

(put 'sub '(polynomial polynomial) subtract-poly)
