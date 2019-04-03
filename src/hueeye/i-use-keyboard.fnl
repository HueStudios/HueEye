(local i-selectable (require :selectable))

(lambda i-use-keyboard [target]
  (when (not target.is-selectable)
    (i-selectable))
  (lambda target.on-key-pressed-global [])
  (lambda target.on-key-pressed [])
  (lambda target.on-text-input-global [])
  (lambda target.on-text-input [])
  (set target.uses-keyboard true))
