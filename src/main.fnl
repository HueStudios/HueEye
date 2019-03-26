(local text (require :hueeye.text))
(local widget-manager (require :hueeye.widget-manager))

(local my-text (text 10 10 200 50 "Hello World"))

(fn love.update [dt])

(fn love.draw []
  (love.graphics.clear (/ 36 255) (/ 36 255) (/ 36 255))
  (my-text.draw))
