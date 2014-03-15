;; EXERCISE 2.35

; This is once again another procedure that would be straight forward
; if we were just working with a list. If we were just working with a
; list, then our lives would be simpler. Every time we select a car
; while cdring down the list, the car would be a simple element and
; life would be good.
;
; But we're not working with lists; we're working with maps. And the
; car at any point could itself be a list. Hopefully it's just one
; list and count-leaves can go to work. Luckily count-leaves has our
; back because it's always checking to see if the car is itself a list
; and appropriately calls accumulate on any sublists, which returns an
; accululation to be used in the top-level accumulation.
(define (count-leaves tree)
  (accumulate (lambda (sub-tree accumulated-leaves)
                  (+ (if (pair? sub-tree)
                         (count-leaves sub-tree)
                         1)
                     accumulated-leaves))
                0
                tree))
  
