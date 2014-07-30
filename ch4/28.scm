;;; EXERCISE 4.28

;;; Any example of a higher order procedure that applies one of its
;;; procedure arguments will do:
;;;
(define (apply p a)
  (p a))

(apply null? 5)
