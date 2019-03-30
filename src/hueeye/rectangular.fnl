(local bound (require :hueeye.bound))
(lambda rectangular [x y width height ?parent ?color]
  (local rectangular-widget (bound x y ?parent ?color))
  (set rectangular-widget._width width)
  (set rectangular-widget._height height)

  (fn rectangular-widget.get-width []
    rectangular-widget._width)

  (fn rectangular-widget.get-height []
    rectangular-widget._height)

  (lambda rectangular-widget.set-width [width]
    (set rectangular-widget._width width))

  (lambda rectangular-widget.set-height [height]
    (set rectangular-widget._height height))

  (fn occlude-child-elements-begin [])

  (fn occlude-child-elements-end [])


  (lambda rectangular-widget.is-inside? [x y]
    (var result false)
    (local start-x (+ (rectangular-widget.get-global-x)))
    (local end-x (+ (rectangular-widget.get-global-x) (rectangular-widget.get-width)))
    (local start-y (+ (rectangular-widget.get-global-y)))
    (local end-y (+ (rectangular-widget.get-global-y) (rectangular-widget.get-height)))
    (when (and (> x start-x) (< x end-x) (> y start-y) (< y end-y))
      (set result true))
    result)
  rectangular-widget)
