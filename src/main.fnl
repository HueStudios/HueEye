(local text (require :hueeye.text))
(local widget-manager (require :hueeye.widget-manager))
(local panel (require :hueeye.panel))
(local utils (require :hueeye.utils))

(local my-panel (panel 10 10 200 50))
(local my-text (text 10 10 200 50 "Hello World"))

(fn draw-widget [widget]
  (when widget.draw
    (widget.draw)))

(widget-manager.add-to-pipeline utils.empty draw-widget utils.empty true)

(fn love.update [dt])

(fn love.draw []
  (love.graphics.clear (/ 36 255) (/ 36 255) (/ 36 255))
  (widget-manager.widget-pipeline))
