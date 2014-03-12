;; EXERCISE 2.4

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))


; (car (cons 1 2))
; (car (lambda (m) (m x y))
; ((lambda (m) (m x y) (lambda (p q) p)))
; ((lambda (p q) p) x y)
; x
