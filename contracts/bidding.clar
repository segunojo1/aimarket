(define-map bids
  { model-id: uint, bidder: principal }
  { amount: uint, timestamp: uint })

(define-public (place-bid (model-id uint) (amount uint))
  (begin
    (asserts! (> amount u0) (err u700))
    (map-set bids { model-id: model-id, bidder: tx-sender } { amount: amount, timestamp: block-height })
    (ok "Bid placed successfully!"))
  )

(define-public (accept-highest-bid (model-id uint))
  (begin
    (let ((highest-bidder (fold bids (fn (entry best) (if (> (get amount entry) (get amount best)) entry best)) { amount: u0 })))
      (asserts! (> (get amount highest-bidder) u0) (err u701))
      (map-set licenses { buyer: (get bidder highest-bidder), model-id: model-id } { purchase-timestamp: block-height, licensed: true })
      (map-delete bids { model-id: model-id, bidder: (get bidder highest-bidder) })
      (ok "Bid accepted and model licensed to the highest bidder!"))
    )
  )
