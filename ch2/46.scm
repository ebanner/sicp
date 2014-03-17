;; EXERCISE 2.46

; Constructor
(define (make-vect x y)
  (list x y))

; Selectors
(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cadr v))

; (v_1, v_2) + (w_1, w_2) = (v_1 + w_1, v_2 + w_2)
(define (add-vect v w)
  (make-vect (+ (xcor-vect v) (xcor-vect w))
             (+ (ycor-vect v) (ycor-vect w))))

; (v_1, v_2) - (w_1, w_2) = (v_1 - w_1, v_2 - w_2)
(define (sub-vect v w)
  (make-vect (- (xcor-vect v) (xcor-vect w))
             (- (ycor-vect v) (ycor-vect w))))

; (v_1, v_2) - (w_1, w_2) = (v_1 - w_1, v_2 - w_2)
(define (scale-vect c v)
  (make-vect (* c (xcor-vect v))
             (* c (ycor-vect v))))
