(local text (require :hueeye.text))
(local widget-manager (require :hueeye.widget-manager))
(local panel (require :hueeye.panel))
(local utils (require :hueeye.utils))
(local render-manager (require :hueeye.render-manager))
(local mouse-manager (require :hueeye.mouse-manager))
(local button (require :hueeye.button))

(local my-panel (panel 10 10 200 50))
(local my-text (text 10 10 200 50 "Hello World"))
(local my-button (button 100 100 200 50))


(fn love.update [dt])

(fn love.draw []
  (love.graphics.clear (/ 36 255) (/ 36 255) (/ 36 255))
  (widget-manager.widget-pipeline))
