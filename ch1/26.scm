;;EXERCISE 1.26

; Rewriting fast-expt with multiplication like that results in a
; tree-recursive structure, where every node will eventually get down to
; exp = 1. The number of nodes in the tree will be precisely exp and
; we'll have to do that many multiplications.
