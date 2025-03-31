(define-map logs
  { log-id: uint }
  { event-name: (buff 100), details: (buff 250), timestamp: uint })

(define-public (log-event (log-id uint) (event-name (buff 100)) (details (buff 250)))
  (begin
    (map-set logs { log-id: log-id } { event-name: event-name, details: details, timestamp: block-height })
    (ok "Event logged!"))
  )