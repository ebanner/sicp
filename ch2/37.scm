;; EXERCISE 2.37

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))

; Credit to Eli Bendersky for this solution. So frustratingly simple.
(define (transpose mat)
  (accumulate-n cons '() mat))

; The way to multiply two matricies proceeds as follows: In the
; process of mapping every row, we need to map every element in the
; row to the dot product of the current row and the corresponding
; column of the element. The only tricky part is getting the
; corresponding column of the row element. We achieve this by using
; the special form of map that takes in a procedure of n arguments
; with n lists and applies the procedure to the first element in each
; list and returns a new list of the result after doing this to every
; element.
;
; Note that when we define the second map on each element, the row is
; still in scope, which is critical to being able to retrieve the
; corresponding row & column of an element.
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (map (lambda (elem col) (dot-product row col))
                row cols))
         m)))
