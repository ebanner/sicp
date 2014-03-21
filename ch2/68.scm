;; EXERCISE 2.68

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

; Strategy:
; Trivial case (Tree is leaf):
;   Symbol of leaf is the symbol -> sequence of 0s & 1s accumulated
;   Symbol of leaf is NOT symbol -> signal error
;
; Recursive case (Complex tree):
;  Save off the left subtree & the right subtree
;  Determine which subtree contains the symbol:
;   If the symbol is in neither subtree -> signal error
;   Assume we've built the entire encoded symbol string starting at
;   the correct branch. How do we add to it? All we have to do is cons
;   together a 0 or 1 depending on whether it was the left or right
;   branch and the rest of the encoded string.

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      (if (eq? (symbol-leaf tree) symbol)
          '()
          (error symbol " not found"))
      (let ((l-branch (left-branch tree))
            (r-branch (right-branch tree)))
        (cond ((element-of-set? symbol (symbols l-branch))
               (cons 0 (encode-symbol symbol l-branch)))
              ((element-of-set? symbol (symbols r-branch))
               (cons 1 (encode-symbol symbol r-branch)))
              (else (error symbol "not found in neither left branch nor right branch"))))))
