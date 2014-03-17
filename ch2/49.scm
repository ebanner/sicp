;; EXERCISE 2.49

; part a
(define outline-painter
  (define outline-segments
    (list
     (make-segment (make-vector 0 0) (make-vector 0 1))
     (make-segment (make-vector 0 1) (make-vector 1 1))
     (make-segment (make-vector 1 1) (make-vector 1 0))
     (make-segment (make-vector 1 0) (make-vector 0 0))))
  (segments->painter outline-segments))

; part b
(define X-painter
  (define X-segments
    (list
     (make-segment (make-vector 0 0) (make-vector 1 1))
     (make-segment (make-vector 1 0) (make-vector 0 1))))
  (segments->painter X-segments))

; part c
(define diamond-painter
  (define diamond-segments
    (list
     (make-segment (make-vector 0.5 0) (make-vector 0 0.5))
     (make-segment (make-vector 0 0.5) (make-vector 0.5 1))
     (make-segment (make-vector 0.5 1) (make-vector 1 0.5))
     (make-segment (make-vector 1 0.5) (make-vector 0.5 0))))
  (segments->painter diamond-segments))

; part d
; Left as an exercise to... who[m]?
