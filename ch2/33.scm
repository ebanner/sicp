;; EXERCISE 2.33

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(define (length sequence)
  (define (inc x) (+ 1 x))
  (accumulate (lambda (x y) (inc y)) 0 sequence))
