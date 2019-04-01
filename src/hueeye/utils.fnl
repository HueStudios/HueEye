(local utils {})
(local dictionary ["A" "B" "C" "D" "E" "F" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"])
(lambda utils.get-random-string [length]
  (var result "")
  (for [i 1 length]
    (local this-index (math.random 1 length))
    (local this-character (. dictionary this-index))
    (set result (.. result this-character)))
  result)
(fn utils.empty [])
(lambda utils.decorate-after [original decoration]
  (fn new-function [...]
    (original (unpack arg))
    (decoration (unpack arg)))
  new-function)
(lambda utils.decorate-before [original decoration]
  (fn new-function [...]
    (decoration (unpack arg))
    (original (unpack arg)))
  new-function)

(var current-stencil-depths 0)

(lambda utils.add-mask [mask-function]
  (set current-stencil-depths (+ 1 current-stencil-depths))
  (love.graphics.stencil mask-function :increment 1 true))

(fn utils.set-mask []
  (love.graphics.setStencilTest :equal current-stencil-depths))

(fn utils.unset-mask []
  (love.graphics.setStencilTest))

(fn utils.clear-mask []
  (local width (love.graphics.getWidth))
  (local height (love.graphics.getHeight))
  (fn stencil-function []
    (love.graphics.rectangle :fill 0 0 width height))
  (love.graphics.stencil stencil-function :replace 0)
  (set current-stencil-depths 0))
utils
