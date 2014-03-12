;;EXERCISE 2.9

; The width of an interval is a function solely of the operand intervals
; in the case of addition & subtraction. To see why this is true,
; consider that when adding & subtrating intervals, we know exactly how
; wide the resulting interval is going to be by only looking at the
; width. It doesn't matter in the slightest if the endpoints are
; positive or negative. And when you add or subtract two intervals,
; you don't get radically different intervals. The result is
; expected. The intervals don't ``scale."
;
; e.g. (width [-1, 1]) = 1
;      (width [-2, 2]) = 2
;      (width (+ [-1, 1] [-2, 2])) = (width ([-3, 3)) = 3


; Constrast this with multiplying & dividing. You could have two
; intervals that have a width of one, but when you multiply them, you
; can wind up with an interval with a width of something huge!
;
; e.g. (width [0,  2]) = 1
;      (width [48, 50]) = 1
;      (width (* [0, 2] [48, 50])) = (width ([0, 100)) = 50!
;
; So in the case of multiplying intervals, you're scaling them. How
; wide an interval is is completely irrelevant. It matters only where
; the interval rests on the number line.
;
; So in this case the width of [0, 2] = 1 and the width of [48, 50] =
; 1, but the width of [0, 2] * [48, 50] = 50 /=/ 2
