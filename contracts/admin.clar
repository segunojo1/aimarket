(define-constant admin 'ST1234567890ABCDEFG)

(define-public (remove-model (model-id uint))
  (begin
    (asserts! (is-eq tx-sender admin) (err u600))
    (map-delete models { model-id: model-id })
    (ok "Model removed by admin!"))
  )

(define-public (ban-user (user principal))
  (begin
    (asserts! (is-eq tx-sender admin) (err u601))
    (map-delete users { user: user })
    (ok "User banned!"))
  )
