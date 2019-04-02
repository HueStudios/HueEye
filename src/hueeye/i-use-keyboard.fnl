(local i-selectable (require :selectable))

(lambda i-use-keyboard [target]
  (when (not target.is-selectable)
    (i-selectable))
  (lambda target.on-key-pressed-global [key scancode is-repeat])
  (lambda target.on-key-pressed [key scancode is-repeat])
  (lambda target.on-key-released-global [key scancode])
  (lambda target.on-key-released [key scancode])
  (lambda target.on-text-input-global [text])
  (lambda target.on-text-input [text])
  (set target.uses-keyboard true))
