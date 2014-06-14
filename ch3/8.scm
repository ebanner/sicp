;;; EXERCISE 3.8

(define (trollolololol)
  (let ((seed 5))
    (lambda (n)
      (begin
	(set! seed (- (* 2 seed) n))
	seed))))

(define f (trollolololol))

(+ (f 0) (f 1))
