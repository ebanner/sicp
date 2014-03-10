(define (foo)
  (let ((y 5))
    (lambda () y)
  )
)

; Execute a function of zero parameters n times
(define (loop f n)
  (define (iter i)
    (cond ((= i 0) 'done)
          (else
           (display (f)) (newline)
           (iter (- i 1)))))
  (iter n))
           
