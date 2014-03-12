;; EXERCISE 2.17
;: (last-pair (list 23 72 149 34))
;: (34)

(define (last-pair l)
  (define (last-pair-iter l)
    (if (null? (cdr l))
        (list (car l))
        (last-pair-iter (cdr l))))
  (if (null? l)
      'empty
      (last-pair-iter l)))

