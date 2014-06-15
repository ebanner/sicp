;;EXERCISE 1.37

(define (inc n) (+ n 1))
(define (dec n) (- n 1))

(define (cont-frac n d k)
  (define (cont-frac-recur n d i)
    (if (= i k)
        (/ (n k)
           (d k))
        (/ (n i)
           (+ (d i) (cont-frac-recur n d (inc i))))))
  (cont-frac-recur n d 0))

(define (cont-frac n d k)
  (define (cont-frac-iter k total)
    (if (< k 0)
        total
        (cont-frac-iter (dec k) (/ (n k)
                                   (+ (d k) total)))))
  (cont-frac-iter (dec k)
                  (/ (n k) (d k))))

(define uno (lambda (x) 1.0))
(define phi (/ 1
               (cont-frac uno uno 100)))

;: (cont-frac (lambda (i) 1.0)
;:            (lambda (i) 1.0)
;:            k)
