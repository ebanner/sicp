;; EXERCISE 2.19
(define us-coins (list 1 5 10 25 50))

(define uk-coins (list 100 50 20 10 5 2 1 0.5))

;: (cc 100 us-coins)

(define (cc amount coin-values)
  (define (no-more? x) (null? x))
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (except-first-denomination coins)
  (cdr coins))

(define (first-denomination coins)
  (car coins))

; The order of the coins does not affect the outcome. This is because
; the same combinations of coins left and change left will be
; enumerated. Notice that one ``branch" of the recursion tree goes
; rightward and immediately sets up paths to take with just pennies,
; just nickles, etc.
