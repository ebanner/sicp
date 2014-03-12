;;EXERCISE 2.12

; (make-center-percent 1 10)
; => [0.90, 1.10]

(define (make-center-percent c p)
  (define (percent p) (/ p 100.0))
  (make-interval (- c (* c (percent p)))
                 (+ c (* c (percent p)))))

(define (percentage i)
  (* 100
     (/ (width i)
        (center i))))
