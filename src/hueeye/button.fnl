(local i-actionable (require :hueeye.i-actionable))
(local rectangular (require :hueeye.rectangular))
(local color-scheme (require :hueeye.color-scheme))
(local text (require :hueeye.text))
(lambda button [x y width height ?parent ?text]
  (local button-color color-scheme.button-color)
  (local button-widget (rectangular x y width height ?parent button-color))
  (i-actionable button-widget)
  (fn draw-button []
    (local w (button-widget.get-width))
    (local h (button-widget.get-height))
    (local x (button-widget.get-global-x))
    (local y (button-widget.get-global-y))
    (local color (button-widget.get-color))
    (color.set-to-draw)
    (love.graphics.rectangle "fill" x y w h)
    nil)
  (button-widget.add-before-draw draw-button)
  (when ?text
    (set button-widget._text-widget (text 0 0 width height ?text button-widget))
    
    (fn button-widget.get-text-widget []
      button-widget._text-widget)
    (lambda button-widget.set-text-widget [new-text-widget]
      (set button-widget._text-widget new-text-widget)))
  button-widget)
