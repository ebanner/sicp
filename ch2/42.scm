;; EXERCISE 2.42

; This was a wonderful exercise in debugging... ;)

(define empty-board '())

; All solutions to the the `board-size' queens problem
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; Is the queen n safe from all other queens?
(define (safe? n positions)
  (let ((backward-queens (reverse positions)))
    (let ((prey (car backward-queens))
          (attackers (cdr backward-queens)))
      (null?
       (filter ; attackers in an attacking position
        (lambda (attacker)
          (or (horizontal-threat attacker prey)
             (vertical-threat attacker prey)
             (diagonal-threat attacker prey)))
        attackers)))))

; Predicates for determining if a queen is safe
(define (horizontal-threat q1 q2)
  (= (pos-row q1) (pos-row q2)))

(define (vertical-threat q1 q2)
  (= (pos-col q1) (pos-col q2)))

; Two queens are on the same diagonal if their rows & cols differ by
; the same amount.
(define (diagonal-threat q1 q2)
  (= (abs (- (pos-row q1) (pos-row q2)))
     (abs (- (pos-col q1) (pos-col q2)))))
    
; Constructor & Selectors
(define (make-position row col)
  (list row col))

(define (pos-row pos) (car pos))

(define (pos-col pos) (cadr pos))

; Helper procedures
(define (get-queen n positions)
  (define (list-element n l)
    (if (= n 1)
        (car l)
        (list-element (- n 1) (cdr l))))
  (list-element n positions))

(define (adjoin-position row col positions)
  (append positions (list (make-position row col))))
