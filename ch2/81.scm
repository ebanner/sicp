;; EXERCISE 2.81

(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
;: (put-coercion 'scheme-number 'scheme-number
;:               scheme-number->scheme-number)
;: (put-coercion 'complex 'complex complex->complex)

(define (exp x y) (apply-generic 'exp x y))
;: (put 'exp '(scheme-number scheme-number)
;:      (lambda (x y) (tag (expt x y))))

;;; a. If we call `exp' with two complex number arguments, then
;;; `apply-general' will first look to see if there is a procedure in
;;; the master procedure table called 'exp and has type '(complex
;;; complex). It's not going to find one, so it checks and see if
;;; there is a way to coerce a complex number into a complex
;;; number. It finds one, does so, and then calls `apply-general'
;;; again with the second (or first) complex number coerced. This will
;;; continue on forever.
;;;
;;; b. No, even though `apply-general' does indeed attempt to coerce
;;; data into the same type, it only does so when there is no
;;; corresponding procedure with the number of arguments
;;; provided. This may or may not have been intended by the designers
;;; of `apply-general'.
;;; 
;;; It actually looks like this was intended because in this case the
;;; message "No method for these types" is printed, which is
;;; technically correct.
;;;
;;; c.

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
		(if (eq? type1 type2)
		    (error "No method for these types"
			   (list op type-tags))
		    (let ((t1->t2 (get-coercion type1 type2))
			  (t2->t1 (get-coercion type2 type1)))
		      (cond (t1->t2
			     (apply-generic op (t1->t2 a1) a2))
			    (t2->t1
			     (apply-generic op a1 (t2->t1 a2))))))))))))
