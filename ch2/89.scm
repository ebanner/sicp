;;; EXERCISE 2.89

(define (adjoin-term term term-list)
  (cond ((equal? (the-empty-termlist) term) term-list)
	((the-empty-termlist? term-list) term)
	((= (length term) (length term-list)) (cons (car term) (cdr term-list)))
	(else
	 (if (< (length term) (length term-list))
	     (cons (car term-list) (adjoin-term term (cdr term-list)))
	     (cons (car term) (adjoin-term (cdr term) term-list))))))
(define (the-empty-termlist) '())
(define (first-term term-list) (cons (car term-list)
				     (make-zero-list (length (cdr term-list)))))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))
(define (make-term order coeff) (cons coeff (make-zero-list order)))
(define (order term) (- (length term) 1))
(define (coeff term) (car term))
;;; Make a list of length `len' full of zeros
(define (make-zero-list len)
  (if (equal? len 0)
      '()
      (cons 0 (make-zero-list (- len 1)))))
