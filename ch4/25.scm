;;; EXERCISE 4.25

;; In good old applicative-order Scheme, `factorial' will never
;; terminate. That's because in order to apply `unless' to its arguments,
;; the Scheme interpretor has to evaluate its arguments no matter what.
;; So (* n (factorial (- n 1))) is evaluated unconditionally, resulting
;; in an infinite recursive chain.
