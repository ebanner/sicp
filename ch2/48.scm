;; EXERCISE 2.48

; Constructor
(define (make-segment v w)
  (list v w))

; Selectors
(define (start-segment s)
  (car s))

(define (end-segment s)
  (cadr s))
