;; EXERCISE 2.47


; Representation #1
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

; Selectors
(define (origin-frame f)
  (car f))

(define (edge1-frame f)
  (cadr f))

(define (edge2-frame f)
  (caddr f))


; Representation #2
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

; Selectors
(define (origin-frame f)
  (car f))

(define (edge1-frame f)
  (cadr f))

(define (edge2-frame f)
  (cddr f))
