(define-map models
  { model-id: uint }
  { owner: principal, name: (buff 100), description: (buff 250), price: uint, licensed: bool })

(define-public (upload-model (model-id uint) (name (buff 100)) (description (buff 250)) (price uint))
  (begin
    (asserts! (is-none (map-get? models { model-id: model-id })) (err u200))
    (map-set models { model-id: model-id } { owner: tx-sender, name: name, description: description, price: price, licensed: false })
    (ok "Model uploaded successfully!")
  ))

(define-read-only (get-model (model-id uint))
  (map-get? models { model-id: model-id }))
