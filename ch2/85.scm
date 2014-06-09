;;; EXERCISE 2.85

;;; Project

;;; Imaginary
(put 'project '(imag)
     (lambda (imag) (make-real (real-part imag))))

;;; Real
(put 'project '(real)
     (lambda (real) (make-rat (round real) 1)))

;;; Rational
(put 'project '(rational)
     (lambda (rational) (numer rational)))

;;; Done exactly as desribed in the exercise
(define (drop obj)
  (let ((project (get 'project (type obj))))
    (if (null? project)
	obj				; Already an 'integer
	(let ((projected-obj (project obj)))
	  (let ((raised-obj ((get 'raise (type projected-obj)) projected-obj)))
	    (if ((get 'equ? (list (type raised-obj) (type obj))) obj projected-obj)
		(drop projected-obj)	; Try to drop down again
		obj))))))

;;; Drop the object that's computed after we find a suitable procedure
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (drop (apply proc (map contents args))) ; Did you miss it? Here it is.
          (let ((highest-type (highest-type type-tags)))
	    (let ((coerced-objs (coerce-objs args highest-type)))
	      (apply-generic op coerced-objs)))))))
