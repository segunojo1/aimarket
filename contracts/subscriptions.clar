(define-map subscriptions
  { subscriber: principal, model-id: uint }
  { start-time: uint, duration: uint, active: bool })

(define-public (subscribe-model (model-id uint) (duration uint))
  (begin
    (asserts! (> duration u0) (err u800))
    (map-set subscriptions { subscriber: tx-sender, model-id: model-id } { start-time: block-height, duration: duration, active: true })
    (ok "Subscription activated!"))
  )

(define-read-only (check-subscription (subscriber principal) (model-id uint))
  (match (map-get? subscriptions { subscriber: subscriber, model-id: model-id })
    some (if (> (+ (get start-time some) (get duration some)) block-height) true false)
    false))
