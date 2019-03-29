(local i-clickable (require :i-clickable))
(local color-scheme (require :color-scheme))
(fn [target-widget]
  (when (not taget-widget.is-clickable)
    (i-clickable target-widget))
  (set target-widget._hover-color color-scheme.actionable-hover)
  (set target-widget._drag-color color-scheme.actionable-drag)
  (lambda target-widget.set-hover-color [new-color]
    (set target-widget._hover-color new-color))
  (fn target-widget.get-hover-color []
    target-widget._hover-color)
  (lambda target-widget.set-drag-color [new-color]
    (set taget-widget._drag-color new-color))
  (fn target-widget.get-idle-color []
    target-widget._color)
  (fn target-widget.get-drag-color []
    target-widget._drag-color)
  (var hovering false)
  (var dragging false)
  (fn target-widget.on-action [gx gy x y])
  (fn target-widget.on-mouse-enter [gx gy x y]
    (set hovering true))
  (fn target-widget.on-global-mouse-leave [gx gy x y]
    (set hovering false))
  (fn target-widget.on-mouse-down [gx gy x y button]
    (set dragging true))
  (fn target-widget.on-global-mouse-up [gx gy x y button]
    (set dragging false))
  (fn target-widget.get-color []
    (var to-return (target-widget.get-drag-color))
    (when (not dragging)
      (set to-return (target-widget.get-hover-color)))
    (when (not hovering)
      (set to-return (target-widget.get-idle-color)))
    to-return)
  (fn target-widget.on-mouse-up [gx gy x y]
    (target-widget.on-action gx gy x y)))
