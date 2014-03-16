;; EXERCISE 2.42

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

; Is the queen n safe from queens [0 - n-1]?
(define (safe? n positions)
  (let ((vulnerable-queen (get-queen n positions)))
    (null?
      (filter ; attackers in an attacking position
       (lambda (attacking-queen)
         (or (horizontal-threat attacking-queen vulnerable-queen)
             (vertical-threat attacking-queen vulnerable-queen)
             (diagonal-threat attacking-queen vulnerable-queen)))
        (filter ; attackers
         (lambda (queen-pos) (not (eq? (pos-row queen-pos) n)))
         positions)))))


; Predicates for determining if a queen is safe
(define (horizontal-threat q1 q2)
  (= (pos-row q1) (pos-row q2)))

(define (vertical-threat q1 q2)
  (= (pos-col q1) (pos-col q2)))

(define (diagonal-threat q1 q2)
  (= (+ (pos-row q1) (pos-col q1))
     (+ (pos-row q2) (pos-col q2))))
    
; Constructor & Selectors
(define (make-position row col)
  (list row col))

(define (pos-row pos) (car pos))

(define (pos-col pos) (cadr pos))

; Helper procedures
(define (get-queen n positions)
  (define (list-element n l)
    (if (= n 0)
        (car l)
        (list-element (- n 1) l)))
  (list-element n positions))

(define (adjoin-position row col positions)
  (append positions (make-position row col)))

