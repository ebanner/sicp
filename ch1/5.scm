;;EXERCISE 1.5

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;: (test 0 (p))

;;; With applicative-order evaluation, (test 0 (p)) will result in an
;;; infinite loop. This is because in application-order evaluation, the
;;; left-most expression is evaluated, followed by the arguments. Hence
;;; (p) will be evaluated. Note that (p) loops forever because p is a
;;; procedure with a body of (p). But the subsitution rule, to evaluate
;;; (p), we substitute in the body of p, which is (p). This goes on ad
;;; infinitum.

;;; On the other hand, if the interpretor evaluates (test 0 (p)) with
;;; normal-order evaluation, then the result will be 0. This is because
;;; the arguments to test are not evaluated. By the substitution rule,
;;; (test 0 (p)) becomes:
;;;
;;;   (if (= 0 0)
;;;       0
;;;       (p))
;;;
;;; ...and (p) is never evaluated.
