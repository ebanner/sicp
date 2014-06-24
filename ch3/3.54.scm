;;; EXERCISE 3.54

(define (mul-streams s1 s2)
  (map-stream * s1 s2))

;;; This appears to work. Better not think too hard about it... ;)
(define factorials
  (cons-stream 1 (mul-streams integers factorials)))
