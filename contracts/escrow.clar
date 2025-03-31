(define-map escrow
  { model-id: uint, buyer: principal }
  { amount: uint, released: bool })

(define-public (deposit-escrow (model-id uint) (amount uint))
  (begin
    (asserts! (>= amount u1) (err u400))
    (map-set escrow { model-id: model-id, buyer: tx-sender } { amount: amount, released: false })
    (ok "Payment deposited into escrow!"))
  )

(define-public (release-payment (model-id uint))
  (begin
    (let ((escrow-entry (map-get? escrow { model-id: model-id, buyer: tx-sender })))
      (match escrow-entry
        some (begin
               (map-set escrow { model-id: model-id, buyer: tx-sender } { amount: (get amount escrow-entry), released: true })
               (ok "Payment released!"))
        none (err u401))))
  )