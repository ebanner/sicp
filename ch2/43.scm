;; EXERCISE 2.43

; Louis's version of queens run much slower because it takes a
; different approach to solving the same problem. Our solution takes a
; very ``queen n-1"-centric approach. What I mean by this is the
; fundamental sequence being iterated over is the sequence that
; includes all solutions to the n-1 queens problem with a board of
; size n. For each solution in this sequence, we generate n possible
; solutions that will be filtered for their correctness.
;
; Louis's queens procedure takes a much more ``row"-centric
; approach. What I mean by this is the fundamental sequence Louis
; starts out with is the sequence of all possible rows the nth queen
; can be placed on. For each of these rows, Louis's queens procedure
; has to calculate all solutions to the n-1 queens problem, and the
; possible queen position is appended to each of these sequences.
;
; Louis's queens procedure runs much slower because instead of only
; having to calculate all solutions to the n-1 queens problem once (as
; is the case in our queen's procedure), Lousis's queens procedure has
; to calculate all solutions to the n-1 queens problem for each
; possible new move! His procedure is O(n!)!

;; Louis's version of queens
(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
	 ;; next expression changed
         (flatmap
	  (lambda (new-row)
	    (map (lambda (rest-of-queens)
		   (adjoin-position new-row k rest-of-queens))
		 (queen-cols (- k 1))))
	  (enumerate-interval 1 board-size)))))
  (queen-cols board-size))
