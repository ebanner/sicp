;; EXERCISE 2.61

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= (car set) x) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))
