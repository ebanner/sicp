;;EXERCISE 1.6

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;: (new-if (= 2 3) 0 5)

;: (new-if (= 1 1) 0 5)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; Alyssa P. Hacker will be disappointed. Since new-if is a function,
; (sqrt-iter 1.0 4) is replaced by the it's body by the substitution
; rule. It becomes this: ;
;
;  (new-if (good-enough? 1.0 4)
;          guess
;          (sqrt-iter (improve 1.0 4)
;                     4)))
;
; Now we evaluate the body. Since new-if is a regular old procedure,
; we evaluate the procedure and its arguments and then invoke the
; procedure on the expressions that result from the evaluation of the
; arguments. Let's see, guess is fine. It evaluates to 1.0 in the
; case. Now we try and evaluate (sqrt-iter (imporove 1.0 4) 4). Uh
; oh. That's a function. No problem, we'll just evaluate it. But that
; evaluates to another conditional that has a sqrt-iter in it that we
; have to evaluate. Eventually we'll get to a good enough guess for the
; sqrt-iter procedures that are being substituted (i.e. we'll have
; something like
;
; (new-if (good-enough? 1.0 4)
;          guess
;          (sqrt-iter (improve 4.0 4)
;                     4))
;
; ...but we STILL have to evaluate (sqrt-iter 4.0 4), which itself has
; another sqrt-iter in it we have to evaluate! So you, we will loop
; forever, even though in our resulting bodies for sqrt-iter, we'll have
; the correct square root being passed as an argument to the next
; invocation of sqrt-iter. :(
