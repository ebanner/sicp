;;; EXERCISE 3.55

;;; I have come up with a curious way of reasoning about these
;;; problems that is eerily analagous to the way I reason about
;;; recursive algorithms.
;;;
;;; Coming up with a recursive algorithm requires dealing with two
;;; cases: a trivial case and a hard case.
;;; 
;;; The trivial case is, well, trivial, and the answer can be found a
;;; priori
;;;
;;; In the event you're presented with a hard case, you throw up your
;;; hands. You say that you can 't possiblity solve it. How could you?
;;; You'd have to be superman.
;;;
;;; BUT, you say if someone has solved a simpler problem for you, then
;;; you know how to extend it to solve you problem. And then you write
;;; it down.
;;;
;;; This method (almost) always works for coming up with a recursive
;;; procedure definition.
;;;
;;; Here is the procedure I figured out works (almost) always with
;;; implicitly defined streams:
;;;
;;; What is the first element of the stream? This is the trivial case.
;;; It can be found a priori and can be hard-coded.
;;;
;;; Now the interesting part. Assume the stream exists. That's right;
;;; go ahead and assume you have it. Someone has created it for you.
;;;
;;; Now that you have it, you need to use it to generate the stream
;;; that is the "rest". The hard part. Once you come up with this,
;;; you've got your implicit stream.
;;;
;;; Here's an example; take the integers. What's the first element of
;;; the integers? Well, it's 1. Anyone can find that a priori.
;;;
;;; Now assume we have the integers. That's right, go ahead and
;;; visualize it:
;;;
;;; ( 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 ... )
;;;
;;; Now given the integers, how do we create the "rest" of the
;;; integers? The non-trivial case? Here's what it looks like:
;;;
;;; ( 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 ... )
;;;
;;; Well, it's simple. We just add 1 to every integer! We have a
;;; procedure `add-streams' that will make this really easy for us!
;;;
;;; (add-streams ones integers)
;;;
;;; Now we have everything we need to write our definition! Are you
;;; ready? Here it is...
;;;
;;; (define integers (cons-stream 1 (add-streams ones integers)))
;;;
;;; That's it! Don't you feel smart now?
;;;
;;; Once again, SICP leaves the reader to discover the pattern. Well
;;; played, SICP. Well played... ;)
(define (partial-sum s)
  (define p-sum
    (cons-stream (stream-car s)
		 (add-streams (stream-cdr s)
			      p-sum)))
  p-sum)

