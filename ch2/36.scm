;; EXERCISE 2.36

; We cons together the accumulation of the the first element of each
; list in seqs (by mapping each sublist to its car) and the
; n-accumulation of the cdrs of each sublist of seqs.
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map (lambda (l) (car l)) seqs))
            (accumulate-n op init (map (lambda (l) (cdr l)) seqs)))))

;: (accumulate-n + 0 s)
