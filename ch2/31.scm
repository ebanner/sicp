;; EXERCISE 2.31

; Easy after what I went through in the previous exercise... ;)
(define (square-tree tree) (tree-map square tree))

(define (tree-map f tree)
  (define tree? pair?)
  (map (lambda (head)
         (if (tree? head)
             (tree-map f head)
             (f head)))
       tree))


