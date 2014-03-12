;; EXERCISE 2.22

; The answer list is in the reverse order of the one desired because
; the first thing Louis's iterative map procedure does is cons up the
; square of the first element of the list and then conses up the
; second elemnt to the first. This proceeds for every element in the list.

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (square (car things))
                    answer))))
  (iter items nil))


; The second approach is no better than the first. The first thing the
; second approach does is cons up nil & the square of the first
; element in that order. The next thing that happens is the result so
; far is cons'd up with the square of the next element. And so on.
;
; Eventually what happens is the entire list except the last element
; is contained within the car of the list. In reverse order!

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))
