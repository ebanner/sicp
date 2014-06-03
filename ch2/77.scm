;; EXERCISE 2.77
;; to put in complex package

;: (put 'real-part '(complex) real-part)
;: (put 'imag-part '(complex) imag-part)
;: (put 'magnitude '(complex) magnitude)
;: (put 'angle '(complex) angle)

;;; From a semantic point of view, magnitutde cannot exist at the
;;; top-most layer of our generic arithmentic system becuase complex
;;; numbers are the only type of numbers in our system where the
;;; magnitude can be taken. We have not defined what it means to take
;;; the magnitude of any other kind of number. We could do so, but we
;;; have not yet done so. Currently `magnitude' as a procedure lives
;;; at the complex number layer, which is one layer below the topmost
;;; layer.
;;;
;;; Why this really doesn't work is that `magnitude' has not been
;;; inserted into the table the `apply-generic' looks at. What
;;; `apply-generic' does is it will do a lookup into the master
;;; procedure table with the tags 'complex and 'magnitude and apply
;;; the function that lives there to the contents of the imaginary
;;; number (which is the tag 'rectangle and the contents (3,4)). But
;;; no procedure will be found because no `magnitude' procedure has
;;; been inserted into the table for comlex numbers (only rectangular
;;; and polar numbers).
;;;
;;; Evaluating the above code is a solution because when apply generic
;;; does a `get' on the keys '(complex) and 'magnitude, there will be
;;; a function there. Upon finding this function, `apply-generic' will
;;; strip off the '(complex) tag and evaluate the implemented
;;; `magnitude' procedure by passing it the contents of the imaginary
;;; number (which still has the tag that identifies it as either
;;; rectangular or polar).
;;;
;;; I suppose `apply-generic' is actually invoked twice here. I
;;; thought there would be another generic procedure at the complex
;;; number level, but it seems every level can use the same table
;;; becuase all of the procedures are indexed by tag information.
