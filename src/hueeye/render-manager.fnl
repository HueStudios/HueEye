(local widget-manager (require :hueeye.widget-manager))
(local utils (require :hueeye.utils))

(local render-manager {})

(fn render-manager.draw-widget [widget]
  (when widget.draw
    (widget.draw)))

(widget-manager.add-to-pipeline utils.empty render-manager.draw-widget utils.empty true)

render-manager
