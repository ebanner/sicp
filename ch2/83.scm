;;; EXERCISE 2.83

;;; Integer package
(define (integer->rational int)
  (make-rat int 1))

(put 'raise '(integer)
     (lambda (int) (integer->rational int)))

;;; Rational raise
(define (rational->real rat)
  (make-real (/ (numer rat) (denom rat))))

(put 'raise '(rational)
     (lambda (rat) (rational->real rat)))

;;; Real raise
(define (real->complex real)
  (make-from-real-imag-rectangular real 0))

(put 'raise '(real)
     (lambda (real) (real->complex real)))
