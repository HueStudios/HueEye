(local text (require :hueeye.text))
(local widget-manager (require :hueeye.widget-manager))
(local panel (require :hueeye.panel))
(local utils (require :hueeye.utils))
(local render-manager (require :hueeye.render-manager))
(local mouse-manager (require :hueeye.mouse-manager))
(local button (require :hueeye.button))
(local i-mask (require :hueeye.i-mask))

(local my-panel (panel 10 10 200 50))
(local my-text (text 10 10 200 50 "Hello World"))
(local my-button (button 100 100 50 30 nil "Fire missiles!"))
(i-mask my-button)

(fn my-button.on-action []
  (my-button.set-enabled false))

(fn love.update [dt]
  ;(print (/ 1 dt))
  (widget-manager.widget-pipeline true))

(fn love.draw []
  (love.graphics.clear (/ 36 255) (/ 36 255) (/ 36 255))
  (widget-manager.widget-pipeline false))
