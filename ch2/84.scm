;;; EXERCISE 2.84

;;; Yes, I know this will run into an infinite loop if there is no
;;; such procedure that operates on the coerced objects. I just don't
;;; care to write a check for this.
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((highest-type (highest-type type-tags)))
	    (let ((coerced-objs (coerce-objs args highest-type)))
	      (apply-generic op coerced-objs)))))))

;;; Recursive strategy:
;;;
;;;  Trivial case: The highest type of the empty list is 'integer
;;;  Complicated case: If someone has already computed the highest
;;;  type for the cdr of the list, all we have to do is determine
;;;  whether the car of the list is of a higher type.
(define (highest-type types)
  (if (null? types)
      'integer
      (higher-type (car types)
		   (highest-type (cdr types)))))

;;; Pretty self-explanatory; `type1' is a higher type that `type2' if
;;; it is higher. This is what I live for!
(define (higher-type type1 type2)
  (if (higher? type1 type2)
      type1
      type2))

;;; Arbitrarily raise up `t1' until it either can't be raised anymore
;;; (in which case `t1' is the higher type) or `t1' is the same types
;;; as `t2' (in which case `t2' is the higher type)
(define (higher? t1 t2)
  (if (equal? t1 t2)
      t2
      (let ((raise (get 'raise t1)))
	(if (null? raise)
	    t1
	    (higher? (raise t1) t2)))))



