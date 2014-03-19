;; EXERCISE 2.59

(define (union-set s1 s2)
  (if (null? s1)
      s2
      (let ((union-rest (union-set (cdr s1) s2)))
        (if (element-of-set? (car s1) union-rest)
            union-rest
            (cons (car s1) union-rest)))))
        
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
