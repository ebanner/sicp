;; EXERCISE 2.20

(define (same-parity . z)
  (let ((pred? (if (even? (car z)) even? odd?)))
    (define (aggregate-parity l)
      (cond ((null? l) '())
            ((pred? (car l)) 
             (cons (car l) (aggregate-parity (cdr l))))
            (else
             (aggregate-parity (cdr l)))))
    (aggregate-parity (cdr z))))
