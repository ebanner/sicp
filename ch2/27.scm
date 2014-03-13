;; EXERCISE 2.27

;: (define x (list (list 1 2) (list 3 4)))
;: x
;: (reverse x)
;: (deep-reverse x)

; Deep reverse works just like reverse, only we don't just stick the
; car on the end to be appended afterward; we actually go into the car
; and deep reverse it!
;
; The only additional gotcha is now that we're actually venturing into
; the cars, we might come upon an atom (with no null). Hence we have
; to add in the extra case to check and see if we have an atom. What
; we do is easy enough; just return the atom.
;
; Note that we did not need the check for the atom in the original
; reverse because we froze the cars to be appended later and we only
; followed the cdrs. In a Scheme list, if you follow a cdr, you WILL
; get to a null. There's no way you could possibly run out of links in
; the list without hitting a null.

(define (deep-reverse l)
  (cond ((null? l) '())
        ((not (pair? l)) l)
        (else (append (deep-reverse (cdr l))
                      (list (deep-reverse (car l)))))))
