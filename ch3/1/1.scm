;; EXERCISE 3.1

;; (define A (make-accumulator 5))
;; (A 10)
;; 15
;; (A 10)
;; 25

(define (make-accumulator sum)
  (lambda (inc) (begin
		  (set! sum (+ sum inc))
		  sum)))
