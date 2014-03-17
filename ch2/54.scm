;; EXERCISE 2.54

;: (equal? '(this is a list) '(this is a list))
;: (equal? '(this is a list) '(this (is a) list))

(define (equal? l1 l2)
  (cond ((and (null? l1) (null? l2))
         true)
        ((or (and (null? l1) (not (null? l2)))
             (and (null? l2) (not (null? l1)))
             (not (eq? (car l1) (car l2))))
         false)
        (else
         (equal? (cdr l1) (cdr l2)))))
