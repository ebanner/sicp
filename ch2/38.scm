;; EXERCISE 2.38

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

;: (fold-right / 1 (list 1 2 3))
;: (fold-left / 1 (list 1 2 3))
;: (fold-right list nil (list 1 2 3))
;: (fold-left list nil (list 1 2 3))

; For fold-right & fold-left to accumulate the same value, op must be
; associative.
