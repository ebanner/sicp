;;; EXERCISE 4.27

;; (define w (id (id 10)))
;; => 'ok
;; count
;; => 1
;; w
;; => 10
;; count
;; => 2

;;; Evaluating `count' successively results in two different values. This is
;;; because `w' is run after the first time the value of count is checked. `w'
;;; is defined as a thunk because the result of applying `id' to its argument is
;;; to increment count and evaluate its argument. Hence when `w' is defined,
;;; count is incremented and the argument of `id' is returned, namely a thunk.
;;;
;;; Then, since `w' is a thunk, evaluating it forces the thunk because the thunk
;;; is returned to the top-level of the evaluator, resulting in `count' being
;;; incremented again.
;;;
;;; In an applicative-order language, `(id (id 10))' would have been evaluated
;;; in its entirety, setting `count' to 2 and immediately setting `w' to 10 and
;;; not a thunk.
