;; EXERCISE 2.55

;: (car ''abracadabra)

; The interpretor translates '<expr> to (quote <expr>), so it
; translates ''abracadabra to
; (quote 'abracadabra) to (quote (quote abracadabra)). Remember that
; (quote) takes the expression that comes after it and does not
; evaluate it. So (quote (quote abracadabra)) evaluates to (quote
; abracadabra). The car of this is ``quote".
