;;EXERCISE 2.2

; p & q are points in the plane
(define (make-segment p q)
  (cons p q))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (height-segment s)
  (abs (- (y-point (start-segment s))
          (y-point (end-segment s)))))

(define (width-segment s)
  (abs (- (x-point (start-segment s))
          (x-point (end-segment s)))))

; x & y are coordinates on the plane
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (midpoint-segment s1)
  (make-point (average (x-point (start-segment s1))
                       (x-point (end-segment s1)))
              (average (y-point (start-segment s1))
                       (y-point (end-segment s1)))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))
