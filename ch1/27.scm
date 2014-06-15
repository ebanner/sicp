;; fast-prime?

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))        

(define (pass-fermat-test? n)
  (define (dec a) (- a 1))
  (define (try-it a)
    (= (expmod a n n) a))
  (define (loop a)
    (cond ((= a 0) "Passed Fermat's little theorem")
          ((try-it a) (loop (dec a)))
          (else "Failed Fermat's little theorem")))
  (loop (dec n)))
