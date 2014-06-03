;;; Exercise 2.78

(define (attach-tag tag number)
  (if (number? number)
      number
      (cons tag number)))

(define (contents number)
  (if (pair? number)
      (cdr number)
      number))

(define (type-tag number)
  (if (pair? number)
      (car number)
      'scheme-number))
