;; EXERCISE 2.60

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set) (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

; The efficiency for finding an element is better on average, although
; still O(n). Unioning & Intersecting sets is can be better or
; worse. If you're dealing with sets where you have put in a lot of
; duplicates, they're going to suffer. However, if you have a set with
; few duplicates, you may get lucky more often and have
; element-of-set? catch an element earlier than it would have.
