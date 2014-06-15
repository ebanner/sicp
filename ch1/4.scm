;;EXERCISE 1.4

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; If 0 < b, then the resulting expression is (+ a b)
; If 0 < b, then the resulting expression is (- a b)
