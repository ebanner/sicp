;;EXERCISE 1.3

(define (sum-of-two-largest-squares a b c)
  (if (< a b)
      (if (< a c)
          (sum-of-squares b c)
          (sum-of-squares a b))
      (if (< b c)
          (sum-of-squares a c)
          (sum-of-squares a b))
  )
)
