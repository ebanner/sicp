;; EXERCISE 2.62

(define (union-sets s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else
         (let ((x (car s1)) (y (car s2)))
           (cond ((= x y) (cons x (union-sets (cdr s1) (cdr s2))))
                 ((< x y) (cons x (union-sets (cdr s1) s2)))
                 ((< y x) (cons y (union-sets s1 (cdr s2)))))))))
