;;; EXERCISE 4.11

;;; Constructor
(define (make-binding var val) (cons var val))

;;; Selectors
(define (binding-var binding) (car binding))
(define (binding-val binding) (cdr binding))

;;; Frames implemented as a list of bindings
(define (make-frame variables values)
  (if (null? variables)
      '()
      (cons (make-binding (car variables)
			  (car values))
	    (make-frame (cdr variables)
			(cdr values)))))

(define (frame-variables frame) (map binding-var frame))
(define (frame-values frame) (map binding-val frame))

(define (add-binding-to-frame! var val frame)
  (set! frame (cons (make-frame var val) frame)))
