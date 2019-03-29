(local text (require :hueeye.text))
(local widget-manager (require :hueeye.widget-manager))
(local panel (require :hueeye.panel))

(local my-panel (panel 10 10 200 50))
(local my-text (text 10 10 200 50 "Hello World"))



(fn love.update [dt])

(fn love.draw []
  (love.graphics.clear (/ 36 255) (/ 36 255) (/ 36 255))
  (local master-widget (widget-manager.get-master-widget))
  (master-widget.draw))
