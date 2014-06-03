;;; EXERCISE 2.79

(define (equ? n1 n2)
  (apply-generic 'equ? n1 n2))

;;; Add this to the scheme-number package
(put '=zero? '(scheme-number) (lambda (x) (= x 0)))

;;; Add this to the rational-number package. Assume rational numbers
;;; are already in lowest terms
(put '=zero? '(rational) (lambda (x) (= (numer x) 0)))

;;; Add *this* to the complex-number package
(put '=zero? '(complex) (lambda (z) (= (magnitude z) 0)))
