;; EXERCISE 3.53

;: (define s (cons-stream 1 (add-streams s s)))

;;; This is a stream that has its first element as one and the rest of
;;; the stream is the pairwise sum of each element. Hence the second
;;; element is the first plus the first, which is two. Then the next
;;; is the second element plus the second, which is four. And so on...
