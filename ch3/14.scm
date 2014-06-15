;; EXERCISE 3.14

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

;;; `mystery' reverses a list
;;;
;;; (define v '(a b c d))
;;; v
;;; (a b c d)
;;; (define w (mysetery v))
;;; w
;;; (d c b a)
;;; v
;;; (a)
