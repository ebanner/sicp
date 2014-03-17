;; EXERCISE 2.45

;: (define right-split (split beside below))
;: (define up-split (split below beside))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split (- n 1))))
        (below painter (beside smaller smaller)))))

(define (split main-divide sub-divide)
  (if (= n 0)
      painter
      (let ((smaller (split (- n 1))))
        (main-divide painter (sub-divide smaller smaller)))))
