;;EXERCISE 2.1

(define (make-rat n d)
  (define (negative? x) (< x 0))
  (let ((g (gcd n d)))
    (let ((lowest-n (/ n g)) (lowest-d (/ d g)))
      (cond ((and (negative? lowest-n) (negative? lowest-d))
             (cons (abs lowest-n) (abs lowest-d)))
            ((or  (negative? lowest-n) (negative? lowest-d))
             (cons (- (abs lowest-n)) (abs lowest-d)))
            (else (cons lowest-n lowest-d))))))
        

        
         
         
