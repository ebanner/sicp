;;EXCERCISE 1.11

; f(n) = n, if n < 3
;      = f(n-1) + 2f(n-2) + 3f(n-3), if 3 <= n

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(define (f n)
  (define (dec n) (- n 1))
  (define (f-iter a b c i)
    (if (= i 0)
        c
        (f-iter b c (+ c (* 2 b) (* 3 a)) (dec i))))
  (if (< n 3)
      n
      (f-iter 0 1 2 (- n 2))))
