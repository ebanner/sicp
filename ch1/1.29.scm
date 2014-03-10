;;EXERCISE 1.29

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2)) add-dx b)
     dx))

(define (simpson f a b n)
  (define (inc x) (+ x 1))
  (let ((h (/ (- b a) n)))
    (define (simpson-term k)
      (* (cond ((or (= k 0) (= k n)) 1)
               ((odd? k) 4)
               (else 2))
         (f (+ a (* k h)))))
    (* (/ h 3)
       (sum simpson-term 0 inc n))))
