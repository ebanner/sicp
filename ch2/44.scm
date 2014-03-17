;; EXERCISE 2.44

; A note on recursion: Don't look at (up-split (- n 1)) as some sort
; of abstract thing. You have to look at it as absolutely the picture
; that is generated from doing (up-split (- n 1)). If you don't know
; what that looks like, you better get an idea of what it looks like.
;
; Every non-tail recursive sane algorithm is devised like so. The
; defition states ``I don't know how to solve the problem; But if you
; can solve a simpler problem, I know how to get it to the next step
; without messing it up."
;
; Sub-problems that occur in recursive definitions are not some
; abstract thing. They are absolutely 100% the solution to that
; sub-problems and should be treated as such. This is because,
; although every non-trivial input to the procedue relies on a simpler
; problem being solved first, it will be the case that eventually you
; get to the simplest case, which will be solved. Then the
; second-simplest case knows how to extend the simplest problem one
; iota. Then the third-simplest problem knows how to extend the
; second-simplest problem, and so on. Until you get all the way back
; up to the top-level case. Then that top level case knows how to
; extend the solution just enough to give you the answer.
;
; It's an absolutely beautiful thing.
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split (- n 1))))
        (below painter (beside smaller smaller)))))
