;; EXERCISE 2.65

; Untested - This is just the proof of concept/general idea.
;
; Note that converting each tree to a list is a O(n) operation. The
; performing the fast union defined in Exercise 2.62 of these two
; ordered sets is another O(n) operation. Finally converting this
; ordered list back into a balanced tree is a O(n) operation.
(define (union-set s1 s2)
  (let ((ordered-list-1 (tree->list-1 s1))
        (ordered-list-2 (tree->list-2 s2)))
    (let ((union (fast-union ordered-list-1 ordered-list-2)))
      (list->tree union))))
