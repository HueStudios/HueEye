(local rectangular (require :hueeye.rectangular))
(local color-scheme (require :hueeye.color-scheme))
(lambda text [x y width height text ?parent ?align]
  (local text-color color-scheme.text)

  (local text-widget (rectangular x y width height ?parent text-color))

  (set text-widget._text text)
  (if ?align
    (set text-widget._align ?align)
    (set text-widget._align :center))

  (lambda text-widget.set-text [text]
    (set text-widget._text text))
  (lambda text-widget.set-align [align]
    (set text-widget._align align))

  (fn text-widget.get-text []
    text-widget._text)
  (fn text-widget.get-align []
    text-widget._align)

  (fn draw-text []
    (local font (love.graphics.getFont))
    (local w (text-widget.get-width))
    (local h (text-widget.get-height))
    (local x (text-widget.get-global-x))
    (local line-height (: font :getHeight))
    (var content-height 0)
    (let [(width lines) (: font :getWrap (text-widget.get-text) w)]
      (set content-height (* (# lines) line-height)))
    (local y (- (+ (text-widget.get-global-y) (/ h 2)) (/ content-height 2)))
    (local a (text-widget.get-align))
    (local text (text-widget.get-text))
    (local color (text-widget.get-color))
    (color.set-to-draw)
    (love.graphics.printf text x y w a)
    nil)


  (text_widget.add-before-draw draw-text)

  text-widget)
