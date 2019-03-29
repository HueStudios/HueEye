(local base (require :hueeye.base))
(lambda drawable [x y ?parent ?color]
  (local drawable-widget (base ?parent))

  (set drawable-widget._x x)
  (set drawable-widget._y y)

  (set drawable-widget._color ?color)

  (lambda drawable-widget.set-color [color]
    (set drawable-widget._color color))

  (fn drawable-widget.get-color []
    drawable-widget._color)

  (lambda drawable-widget.set-x [x]
    (set drawable-widget._x x))

  (lambda drawable-widget.set-y [y]
    (set drawable-widget._y y))

  (lambda drawable-widget.add-before-draw [to-add]
    (local old-draw drawable-widget.draw)
    (fn new-draw-function []
      (to-add)
      (old-draw))
    (set drawable-widget.draw new-draw-function))

  (lambda drawable-widget.add-after-draw [to-add]
    (local old-draw drawable-widget.draw)
    (fn new-draw-function []
      (old-draw)
      (to-add))
    (set drawable-widget.draw new-draw-function))

  (fn drawable-widget.get-x []
    drawable-widget._x)

  (fn drawable-widget.get-global-x []
    (var result (drawable-widget.get-x))
    (local parent (drawable-widget.get-parent))
    (when (pcall parent.get-global-x)
      (set result (+ (drawable-widget.get-x) (parent.get-global-x))))
    result)

  (fn drawable-widget.get-y []
    drawable-widget._y)

  (fn drawable-widget.get-global-y []
    (var result (drawable-widget.get-y))
    (local parent (drawable-widget.get-parent))
    (when (pcall parent.get-global-y)
      (set result (+ (drawable-widget.get-y) (parent.get-global-y))))
    result)

  (fn drawable-widget.draw [])

  drawable-widget)
