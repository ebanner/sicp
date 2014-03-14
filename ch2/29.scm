;; EXERCISE 2.29

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;; part a
(define (left-branch m)
  (car m))

(define (right-branch m)
  (cadr m))

(define (branch-length b)
  (car b))

(define (branch-structure b)
  (cadr b))

;; part b
(define (total-weight m)
  (+ (weight-branch (left-branch m)) (weight-branch (right-branch m))))

(define (weight-branch b)
  (if (just-weight? b)
      (branch-structure b)
      (total-weight (branch-structure b))))

(define (just-weight? b)
  (let ((struct (branch-structure b)))
    (and (not (null? struct))
         (not (pair? struct)))))

;;; part c
(define (balanced-mobile? m)
  (and (= (torque (left-branch m)) (torque (right-branch m)))
       (and (balanced-branch? (left-branch m))
            (balanced-branch? (right-branch m)))))

; If the branch has just a weight, it is balanced. If the branch has a
; mobile, then the branch is blananced if the mobile hanging off of it
; is balanced.
(define (balanced-branch? b)
  (if (just-weight? b)
      #t
      (balanced-mobile? (branch-structure b))))

(define (torque b)
  (* (branch-length b) (weight-branch b)))

;;; part d
;(define (make-mobile left right)
;  (cons left right))
;
;(define (make-branch length structure)
;  (cons length structure))

; All *I* need to do is change the implementation of the right-branch
; & branch structure selectors from:
;
;   (define (right-branch m)
;     (cadr m))
;   
;   (define (branch-structure b)
;     (cadr b))
;
; to:
;
;   (define (right-branch m)
;     (cdr m))
;   
;   (define (branch-structure b)
;     (cdr b))
;
; This is because these objects are now being represented as pairs and
; not as lists. But, more importantly, the reason I don't need to
; change anything except the selectors is because I used data
; abstraction to abstract away the implementation details of mobiles &
; branches. This way I don't need to know anything about the
; underlying implementation of mobiles & branches; I just use their
; selectors to get at their attributes.
