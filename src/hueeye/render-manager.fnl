(local widget-manager (require :widget-manager))
(local utils (require :utils))

(local render-manager {})

(fn draw-widget [widget]
  (when widget.draw
    (widget.draw)))

(widget-manager.add-to-pipeline utils.empty draw-widget utils.empty true)

render-manager
