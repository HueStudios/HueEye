(local keyboard-manager {})
(local widget-manager (require :widget-manager))
(local utils (require :utils))
(lambda keyboard-manager.step-widget-key-pressed [widget key scancode is-repeat]
  (when widget.uses-keyboard
    (widget.on-key-pressed-global key scancode is-repeat)
    (when (widget.get-selected)
      (widget.on-key-pressed key scancode is-repeat))))
(lambda keyboard-manager.step-widget-key-released [widget key scancode]
  (when widget.uses-keyboard
    (widget.on-key-released-global key scancode)
    (when (widget.get-selected)
      (widget.on-key-released key scancode))))
(lambda keyboard-manager.step-widget-text-input [widget text]
  (when widget.uses-keyboard
    (widget.on-text-input-global text)
    (when (widget.get-selected)
      (widget.on-text-input text))))
(lambda keyboard-manager.handle-key-pressed [key scancode is-repeat]
  (local master-widget (widget-manager.get-master-widget))
  (utils.run-on-children-down-top
    master-widget
    keyboard-manager.step-widget-key-pressed
    [key scancode is-repeat]))
(lambda keyboard-manager.handle-key-released [key scancode]
  (local master-widget (widget-manager.get-master-widget))
  (utils.run-on-children-down-top
    master-widget
    keyboard-manager.step-widget-key-released
    [key scancode]))
(lambda keyboard-manager.handle-text-input [text]
  (local master-widget (widget-manager.get-master-widget))
  (utils.run-on-children-down-top
    master-widget
    keyboard-manager.step-widget-text-input
    [text]))
