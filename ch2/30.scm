;; EXERCISE 2.30

; (square-tree
;  (list 1
;        (list 2 (list 3 4) 5)
;        (list 6 7)))
; (1 (4 (9 16) 25) (36 49))
;
; (define x (list 1 (list 2 (list 3 4) 5) (list 6 7)))

; Easy
(define (square-tree t)
  (cond ((null? t) '())
        ((not (pair? t)) (square t))
        (else (cons (square-tree (car t))
                    (square-tree (cdr t))))))

; Using higher-order procedures
;
; When defining the procedure that map will be applying, we need to
; only concern ourselves with the cases of an element itself & the
; complicated case of having a subtree we're trying to square.

; We don't need to worry about the possibility of nil. And it's very
; important to understand why. It is because all we have to give to
; map is a procedure that will operate on each element of the list
; (yes, a tree is just a list). What map does is before it tries to
; apply the procedure to the car of the list, is it checks for null
; and returns null. So map itself takes care of the possibility of
; null. We absolutely should NOT be checking for that in the function
; we give to map.
;
; We can think of this higher-order definition in the following way:
; If the tree is just a straight up list, then the initial call to map
; will take care of everything. This is what map does. It applies the
; procedure to the first element of a list, maps the rest of the list,
; and sticks the two together.
;
; So really all we need to worry about is the case where the first
; element of the list is not a simple element we can square. The
; procedure we give to map is totally easy if we didn't have to take
; into account the possibility that the first element in the list
; would itself be a list. Here's what it would look like:
;
; (define (square-tree t)
;   (map (lambda (t) square)))
;
; Totally easy, right?
;
; Well the only complication here is that the first element of the
; list might itself be a list. In this case, all we need to do to is
; call the procedure square-tree which maps the list in turn, and
; accounts for the possibility that this list may in fact contain
; additional lists along the way of this new map.
;
; Remember, map MAKES a list. So if we call map on a sub-tree
; (sub-list), then map is going to return for us a list of elements
; with the procedure applied. And if that subtree has no subtrees,
; then map will happily go along as any old normal map would.
(define (square-tree tree)
  (define tree? pair?)
  (map (lambda (head)
         (if (tree? head)
             (square-tree head)
             (square head)))
       tree))
