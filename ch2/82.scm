;;; Exercise 2.82

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((types-all-others-can-be-coerced-to)
		(filter (lambda (type) (can-be-coerced? type-tags
							type))))
	    (if (not (null? types-all-others-can-be-coerced-to))
		(let ((type-all-others-can-be-coerced-to)
		      (car types-all-others-can-be-coerced-to))
		  (let ((coerced-objs)
			(coerce-objs args
				     type-all-thers-can-be-coerced-to))
		    (apply-generic op coerced-objs)))
		(error "Unable to coerce all args to a single type")))))))

;;; Map each type to its coersion procedure to `type'. If any one of
;;; these types are unable to be coerced to `type' then the following
;;; accululation will result in #f.
(define (can-be-coerced? types type)
  (accumulate (map
	       (lambda (t) (get-coersion t type))
	       types)
	      (lambda (boolean booleans) (and boolean booleans))
	      #t))

;;; Coerce each object by applying the coersion procedure to it
(define (coerce-objs objs type)
  (map (lambda (obj) ((get-coersion (type-tag obj) type) obj))
       objs))

;;; Accumulate
(define (accumulate list proc nil)
  (if (null? list)
      nil
      (proc (car list)
	    (accumulate (cdr list) proc nil))))

;;; Filter
(define (filter list predicate?)
  (cond ((null? list) '())
	((predicate? (car list)) (cons (car list) (filter (cdr list)
							  predicate?)))
	(else (filter (cdr list) predicate?))))

;;; For an example of how `apply-generic' is insufficient for even the
;;; two case scenario, consider the case when there is a mixed type
;;; procedure in the procedure table indexed by '(type2 type1). If
;;; that permutation of types existed in the table, it would have been
;;; missed by `apply-generic'. In fact any mixed-type operation will
;;; be missed as long as it's not the permutation that is initially
;;; passed into `apply-generic'.
