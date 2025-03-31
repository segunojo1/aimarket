(define-map users
  { user: principal }
  { name: (buff 100), role: (buff 20), registered: bool })

(define-public (register-user (name (buff 100)) (role (buff 20)))
  (begin
    (asserts! (is-none (map-get? users { user: tx-sender })) (err u100))
    (map-set users { user: tx-sender } { name: name, role: role, registered: true })
    (ok "User registered successfully!")
  ))

(define-read-only (get-user (user principal))
  (map-get? users { user: user }))
