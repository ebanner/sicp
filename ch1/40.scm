;;EXERCISE 1.40

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c))) 

;: (newtons-method (cubic a b c) 1)
