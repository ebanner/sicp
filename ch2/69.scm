;; EXERCISE 2.69

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; Successive-Merge strategy:
;
; Trivial case:
;  If size of the set we're merging is just one, then the Huffman
;  tree is just the single tree in the list
;
; Complicated case:
;  Save off the lowest two elements
;  Remove them from the list
;  Make a tree out of them
;  Put them back into the list
;  And just assume the problem has been solved for us

; Assume we don't get passed the empty list :)
(define (successive-merge lairs) ; set of leaves & pairs
  (if (eq? (length lairs) 1)
      (car lairs)
      (let ((t1 (car lairs))   ; smallest tree
            (t2 (cadr lairs))) ; second-smallest tree
        (successive-merge (adjoin-set (make-code-tree t1 t2)
                                      (cddr lairs))))))

; Removes leaf with symbol symbol (assumes there's only one such symbol)
(define (remove symbol set)
  (cond ((null? set) '())
        ((eq? (symbol-leaf (car set)) symbol) (cdr set))
        (else (cons (car set) (remove symbol (cdr set))))))
