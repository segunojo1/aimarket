(define-map audits
  { model-id: uint }
  { auditor: principal, approved: bool, timestamp: uint })

(define-public (audit-model (model-id uint) (approved bool))
  (begin
    (asserts! (is-eq tx-sender 'STAUDITOR12345) (err u900))
    (map-set audits { model-id: model-id } { auditor: tx-sender, approved: approved, timestamp: block-height })
    (ok "Audit completed!"))
  ))

(define-read-only (is-model-verified (model-id uint))
  (match (map-get? audits { model-id: model-id })
    some (get approved some)
    false))
