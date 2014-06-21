;;; EXERCISE 3.27

;;; To see why `memo-fib' takes a number of steps proportional to n,
;;; note that (memo-fib n) always becomes (memo-fib (- n 1)) and
;;; (memo-fib (- n 2)) (in a non-trivial case). Note that (memo-fib (-
;;; n 1)) will always be evaluated *before* (memo-fib (- n 2)). Hence
;;; we'll recurse down by 1 until we get all the way down to (memo-fib
;;; 1) or (memo-fib 0). Then we'll work our way back up the tree,
;;; caching each result along the way.
;;;
;;; Notice the second expression yet to be evaluated (memo-fib (- n
;;; 2)) will always be cached by the time we get around to evaluating
;;; it. Since it only takes constant time for such a lookup, the whole
;;; kitten-cabootle will take apprximately 3n steps to complete, which
;;; is O(n)v


