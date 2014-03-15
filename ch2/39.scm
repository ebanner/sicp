;; EXERCISE 2.39

(define (reverse l)
  (fold-right (lambda (head already-reversed-list)
                (append already-reversed-list (list head)))
              '()
              l))

; There is a huge difference between fold-left & fold-right in this
; particular problem. The interface for the accumulator function is
; the same (you take a list of already sorted elements & another
; element and have to accumulate them in such a way as to preserve the
; reversed order of the list.
;
; In the case of fold-right, the reversed list that needs to be
; accumulated to is the reversed list of all the elements from the
; right. Hence you need to add the element to the end of the partially
; sorted list to not screw up the reverse ordering.
;
; In the case of fold-left, the reversed list that needs to be
; accumulated to is the reversed list of all the elements from the
; left. Hence you need to add the element to the left of the partially
; reversed list to not screw up the ordering.

(define (reverse l)
  (fold-left (lambda (already-reversed-list head)
                (append already-reversed-list (list head)))
             '()
             l))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))
