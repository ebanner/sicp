;;EXERCISE 1.39

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

; Not sure why I'm not getting the right answer for this one... :(
(define (tan-cf x)
  (define (n k) (+ (* 2 k) 1))
  (define (d k)
    (if (= k 0)
        x
        (- (square x))))
  (cont-frac n d 100))

;: (cont-frac (lambda (i) 1.0)
;:            (lambda (i) 1.0)
;:            k)
