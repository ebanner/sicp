; ------------------------------------------------
;          Programs that use rectangles
; ------------------------------------------------
;
;        Rectangles in the problem domain
;
; ------------------------------------------------
;                 area  perimeter
; ------------------------------------------------
;
;              Rectangles as points                     Rectangles as segments
;
; ------------------------------------------------------------------------------------------------
;         make-rect  height  width  origin         make-rect  height  width  origin
; ------------------------------------------------------------------------------------------------


; Rectangles in the problem domain
;
; (area r)
; => 1
;
; (perimeter r)
; => 4

(define (area r)
  (* (height-rect r)

               (width-rect r)
  )
)
  
(define (perimeter r)
  (+           (width-rect r)

     (height-rect r)         (height-rect r)

               (width-rect r)
  )
)


; Rectangles as segments
;
; (make-rect s1 s2)
; => rectangle
;
; (point-rect r)
; => bottom-left point
;
; (height-rect r)
; => 1
;
; (width-rect r)
; => 1

(define (make-rect s1 s2)
  (cons s1 s2))

(define (point-rect r)
  (start-segment (car r)))

(define (height-rect r)
  (height-segment (car r)))

(define (width-rect r)
  (width-segment (cdr r)))

; ------------------------------------------------

; Rectangles as points
;
; (make-rect p q r s)
; => rectangle
;
; (point-rect r)
; => bottom-left point
;
; (height-rect r)
; => 1
;
; (width-rect r)
; => 1
;
; Rectangle looks like this:
;
;    q  ___________________________________  r
;      |                                   |
;      |                                   |
;      |                                   |
;      |                                   |
;      |                                   |
;      |                                   |
;      |___________________________________|
;    p                                       s

(define (make-rect p q r s)
  (cons p (cons q (cons r s))))
  
(define (point-rect r) (car r))

(define (height-rect r)
  (abs (- (y-point (car r))
          (y-point (car (cdr r))))))

(define (width-rect r)
  (abs (- (x-point (car r))
          (x-point (car (cdr (cdr r)))))))
