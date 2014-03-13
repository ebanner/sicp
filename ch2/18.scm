;; EXERCISE 2.18
;: (reverse (list 1 4 9 16 25))

(define (reverse l)
  (define (reverse-iter l aggregate)
    (if (null? l)
        aggregate
        (reverse-iter (cdr l) (cons (car l) aggregate))))
  (reverse-iter l '()))

(define (reverse l)
  (if (null? l)
      '()
      (append (reverse (cdr l))
              (list (car l)))))
