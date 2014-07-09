;;; EXERCISE 4.15

;;; We evaluate (try try). Either two things can happen: either
;;; (halts? try try) returns true (i.e. try applied to try halts) or
;;; (halts? try try) returns false (i.e. try applied to try runs
;;; forever). Well we're applying try to try now. Let's examine the
;;; possible scenarios:
;;;
;;; If (halts? try try) returns true (i.e. (try try) halts), then we
;;; hit `(run-forever). Notice that this program itself is (try try).
;;; So (halts? try try) evaluating to true told us that (try try)
;;; halts, but that very program is running forever!
;;;
;;; Now consider the only other case; that (halts? try try) returns
;;; false (i.e. (try try) runs forever). If that's the case, we hit
;;; the part of the `if' that halts ('halted). So (halts? try try)
;;; evaluating to false told us that (try try) runs forever, but THAT
;;; VERY PROGRAM halted! This is a contradiction, also.
;;;
;;; Since `try' is a valid procedure and assuming `halt?' exists leads
;;; to a contradiction no matter what, it is impossible for such a
;;; `halt?' procedure to exist.
;;;
;;; I think that the pitfall here comes from the fact that `halt?'
;;; makes a guarantee about every single procedure, which includes
;;; procedures the contain calls to `halt?'.
