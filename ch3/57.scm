;;; EXERCISE 3.57

;;; The number of additions we have to do are on the order of n if we
;;; use memoization because all of the `add-stream' that are piling up
;;; are able to get the stream-cadr (the next element in the stream)
;;; in a constant amount of time. There will be n of these
;;; `add-stream' piling up, so it will take time proportional to n.

;;; If we don't use memoization, then the number of `add-streams'
;;; procedures you have to evaluate double each time.
