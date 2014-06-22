;; EXERCISE 3.52

;;; This exercise was extrememly elucidating. I realized that after
;;; doing this exercise that the cdr in a stream is always a
;;; procedure, no matter what. So to get the next element in a stream
;;; *always* requires calling a procedure. The big difference is in
;;; whether we have to recompute the next element or it's already been
;;; cached for us. This only applied to streams that are defined and
;;; used multiple times.

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

;;; (define seq (stream-map accum (stream-enumerate-interval 1 20)))
;;; => sum
;;; 1
;;; (define y (stream-filter even? seq))
;;; => sum
;;; 3
;;; (define z (stream-filter (lambda (x) (= (remainder x 5) 0))
;;;                          seq))
;;; => sum
;;; 10
  
;;; (stream-ref y 7)
;;; => sum
;;; 114
;;; (display-stream z)
;;; => sum
;;; 10
;;; 15
;;; 45
;;; 55
;;; 85
;;; 130

;;; These responses would not differ. The only thing that would differ
;;; is the time it takes to compute these procedures. If we had not
;;; used `memo-proc' in the definition of `delay' then there would
;;; have been no caching going on and we would have had to recompute
;;; the next link in the chain for `seq' every time we wanted it.
;;;
;;; That brings up an interesting point with this caching mechanism;
;;; Caching is even more important for defining streams that are the
;;; results of filters. To see why this is the case, consider if we
;;; created a stream from a filter where the elements were very
;;; sparse. With caching, we're able to jump right to the next element
;;; in the filtered stream as opposed to trying every element again
;;; that did not pass the filter test.
