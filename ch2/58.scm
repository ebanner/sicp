; part a
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-exponentiation (base exp)
                                            (make-sum (exponent exp) '-1))))
        (else
         (error "unknown expression type -- DERIV" exp))))


;; representing algebraic expressions

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))


;: (deriv '(x + 3) 'x)
;: (deriv '(x * y) 'x)
;: (deriv '((x * y) * (x + 3)) 'x)

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p) (car p))

(define (multiplicand p) (caddr p))

(define (exponentiation? e)
  (and (pair? e) (eq? (cadr e) '**)))

(define (base exp)
  (car exp))

(define (exponent exp)
  (caddr exp))

(define (make-exponentiation e1 e2)
  (cond ((=number? e2 0) 1)
        ((=number? e2 1) e1)
        ((and (number? e1) (number? e2)) (expt e1 e2))
        (else (list e1 '** e2))))

; (exponentiation? e)
; => #t if e is of the form ax^b

; (base e)
; => the base

; (exponent e)
; => the exponent

; (make-exponentiation e1 e2 e3)
; => creates an exponentiation expression

; part b
;
; Nope, can't do it... ;)
