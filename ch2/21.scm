;; EXERCISE 2.21
;: (square-list (list 1 2 3 4))

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items))
            (square-list (cdr items)))))

(define (square-list items)
  (map square items))
