;;; EXERCISE 4.25

;; In good old applicative-order Scheme, `factorial' will never
;; terminate. That's because in order to apply `unless' to its arguments,
;; the Scheme interpretor has to evaluate its arguments no matter what.
;; So (* n (factorial (- n 1))) is evaluated unconditionally, resulting
;; in an infinite recursive chain.
;;
;; Yes, this definition will work in a normal-order language. This is
;; because the expression (* n (factorial (- n 1))) will only be
;; evaluated if it's called upon. That is, when `n' is anything other
;; than 1.
