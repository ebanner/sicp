;;; EXERCISE 4.21

;;; a.
((lambda (fib)
   (fib fib 10))
 (lambda (ft k)
   (cond ((= k 0) 0)
	 ((= k 1) 1)
	 (else (+ (ft ft (- k 1))
		  (ft ft (- k 2)))))))

;;; b.
(define (f x)
  (define (even? n)
    (if (= n 0)
        true
        (odd? (- n 1))))
  (define (odd? n)
    (if (= n 0)
        false
        (even? (- n 1))))
  (even? x))

((lambda (even? odd?)
   (even? even? odd? 2))
 (lambda (ev? od? k)
   (if (= k 0) true (od? od? ev? (- k 1))))
 (lambda (od? ev? k)
   (if (= k 0) false (ev? ev? od? (- k 1)))))
