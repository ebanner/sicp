;; EXERCISE 2.64

; part a

; partial-tree first defines a trivial case. It knows how to make a
; balanced tree out of 0 elements: It just cons's together the null
; list and the elements left over (see definition given by preceding
; paragraph.
;
; Otherwise, we're dealing with a complicated case. At a high level,
; what partial-tree does is it computes the left balanced subtree (of
; the first n/2 elements in the list), and the right balanced
; subtree. When computing the right balanced subtree, the middle
; element is not included. It is finally used after both balanced
; subtrees are created to use as the value of the node that is going
; to branch off the balanced left & right subtrees.
;
; To be more pedantic, what parital-tree does is it:
;
;  . Computes the size of the balanced left subtree
;  . Computes the left subtree and the elements that were not able to
;    be used with this result
;  . Saves off the left subtree
;  . Saves off the elements not used in the left subtree (that should
;    have been used)
;  . Computes the size of the right subtree (leaving out the middle
;    element) 
;  . Saves off the middle element of the list
;  . Computes the right subtree along with all the elements that were
;    not able to be used (which should have been able to be used)
;  . Saves off the right subtree
;  . Saves off the remaining elements
;  . Makes a tree out of the middle element, the left subtree that was
;    saved off, the right subtree that was saved off, and then cons's
;    together this with the remaining elements that were not able to
;    be used 

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; part b
; The order of growth is O(n) because element element is accessed
