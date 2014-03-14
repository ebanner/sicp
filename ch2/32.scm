;; EXERCISE 2.32

; The only way to come up with a procedure like this is to be an
; expert in wishful thinking. The idea of this procedure is this:
; 
; Assume we already have a set containing all of the subsets of the
; set comprising every element except the first. How do we generate
; the remaining subsets? We take the set that's been handed to us by
; wishful thinking and append to it the same set, but with the first
; element added in each of the subsets.
;
; The only way to wield this procedure is to _belive_ it works. You
; needn't have wizardly powers; only strong faith.
(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (lambda (subset-not-containing-front-element)
                       (append (list (car s))
                               subset-not-containing-front-element)) rest)))))
