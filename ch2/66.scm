;; EXERCISE 2.66

; UNTESTED

(define (lookup key set)
  (if (null? set)
      false
      (let ((entry-key (key (entry set))))
        (cond ((eq? key entry-key) (entry set))
              ((< key entry-key) (lookup (left-branch set)))
              ((< entry-key key) (lookup (right-branch set)))))))
