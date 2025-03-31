(define-map reputation
  { user: principal }
  { score: uint })

(define-public (rate-user (user principal) (score uint))
  (begin
    (asserts! (<= score u5) (err u500))
    (let ((current (map-get? reputation { user: user })))
      (match current
        some (map-set reputation { user: user } { score: (+ (get score current) score) })
        none (map-set reputation { user: user } { score: score })))
    (ok "User rated successfully!"))
  )

(define-read-only (get-reputation (user principal))
  (map-get? reputation { user: user }))
