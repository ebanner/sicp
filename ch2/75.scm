;;; EXERCISE 2.75

;;; EXAMPLE CODE
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

;;; Straight up legit code
(define (make-from-mag-ang mag angle)
  (lambda (op)
    (cond ((equal? op 'real-part) (* mag (cos angle)))
	  ((equal? op 'imag-part) (* mag (sin angle)))
	  ((equal? op 'magnitude) (mag))
	  ((equal? op 'angle) (angle)))))
