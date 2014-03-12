;; EXERCISE 2.5

; (car (cons 1 2))
; => 1
;
; (cdr (cons 1 2))
; => 2

(define (cons x y)
  (* (expt 2 x) (expt 3 y)))

(define (car z)
  (if (odd? z)
      0
      (+ 1 (car (/ z 2)))))

(define (cdr z)
  (if (not (= (modulo z 3) 0))
      0
      (+ 1 (cdr (/ z 3)))))
