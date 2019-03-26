(lambda color [r g b a]
  (local new-color {:r (/ r 255) :g (/ g 255) :b (/ b 255) :a (/ a 255)})
  (fn new-color.set-to-draw []
    (love.graphics.setColor new-color.r new-color.g new-color.b new-color.a))
  new-color)
color
