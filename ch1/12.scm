;;EXERCISE 1.18

; l -> numbers to the left of the number
; r -> numbers to the right of the number
(define (blaise l r)
  (define (dec n) (- n 1))
  (if (or (= l 0) (= r 0))
      1
      (+ (blaise (dec l) r)
         (blaise l (dec r)))))
