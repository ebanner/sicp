;; EXERCISE 2.41

(define (ordered-triples-that-sum-up-to n)
  (filter (lambda (triplet) (eq? (+ (car triplet)
                                    (cadr triplet)
                                    (caddr triplet))
                                 n))
          (flatmap (lambda (i)
                 (flatmap (lambda (j)
                        (map (lambda (k) (list k j i))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
               (enumerate-interval 1 n))))
