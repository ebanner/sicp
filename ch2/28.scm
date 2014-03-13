;; EXERCISE 2.28

;: (define x (list (list 1 2) (list 3 4)))
;: (fringe x)
;: (fringe (list x x))

; Fringe is easy. All we have to do is test if we're at a leaf. If
; we're at a leaf, we just return a list containing the leaf value and
; let append do the heavy lifting.
;
; Note that we make a list only out of leaf values and NOT nulls. If
; we made lists out of nulls in addition to leaf values, we would get
; a bunch of empty lists in our resultant fringe list. That might make
; for an interesting representation of the tree so you could
; reconstruct it...

(define (fringe t)
  (cond ((null? t) '())
        ((not (pair? t)) (list t))
        (else (append (fringe (car t))
                      (fringe (cdr t))))))
