(define-map licenses
  { buyer: principal, model-id: uint }
  { purchase-timestamp: uint, licensed: bool })

(define-public (purchase-license (model-id uint))
  (begin
    (let ((model (map-get? models { model-id: model-id })))
      (match model
        some (begin
               (asserts! (is-eq (get licensed model) false) (err u300))
               (map-set licenses { buyer: tx-sender, model-id: model-id } { purchase-timestamp: block-height, licensed: true })
               (ok "License purchased successfully!"))
        none (err u301))))
  ))

(define-read-only (check-license (buyer principal) (model-id uint))
  (map-get? licenses { buyer: buyer, model-id: model-id }))
