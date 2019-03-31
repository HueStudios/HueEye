(local i-clickable (require :hueeye.i-clickable))
(local color-scheme (require :hueeye.color-scheme))
(local utils (require :hueeye.utils))
(fn [target-widget]
  (when (not target-widget.is-clickable)
    (i-clickable target-widget))
  (set target-widget._hover-color color-scheme.ACTIONABLE-HOVER-COLOR)
  (set target-widget._drag-color color-scheme.ACTIONABLE-DRAG-COLOR)
  (lambda target-widget.set-hover-color [new-color]
    (set target-widget._hover-color new-color))
  (fn target-widget.get-hover-color []
    target-widget._hover-color)
  (lambda target-widget.set-drag-color [new-color]
    (set target-widget._drag-color new-color))
  (fn target-widget.get-idle-color []
    target-widget._color)
  (fn target-widget.get-drag-color []
    target-widget._drag-color)
  (var hovering false)
  (var dragging false)
  (fn target-widget.on-action [gx gy x y])
  (fn on-mouse-enter [gx gy x y]
    (set hovering true))
  (set target-widget.on-mouse-enter
    (utils.decorate-after target-widget.on-mouse-enter on-mouse-enter))
  (fn on-global-mouse-leave [gx gy x y]
    (set hovering false))
  (set target-widget.on-global-mouse-leave
    (utils.decorate-after target-widget.on-global-mouse-leave on-global-mouse-leave))
  (fn on-mouse-down [gx gy x y button]
    (set dragging true))
  (set target-widget.on-mouse-down
    (utils.decorate-after target-widget.on-mouse-down on-mouse-down))
  (fn on-global-mouse-up [gx gy x y button]
    (set dragging false))
  (set target-widget.on-global-mouse-up
    (utils.decorate-after target-widget.on-global-mouse-up on-global-mouse-up))
  (fn on-mouse-up [gx gy x y]
    (target-widget.on-action gx gy x y))
  (set target-widget.on-mouse-up
    (utils.decorate-after target-widget.on-mouse-up on-mouse-up))
  (fn target-widget.get-color []
    (var to-return (target-widget.get-drag-color))
    (when (not dragging)
      (set to-return (target-widget.get-hover-color)))
    (when (not hovering)
      (set to-return (target-widget.get-idle-color)))
    to-return)
  (set target-widget.is-selectable true))
