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

(fn utils.add-mask [mask-function]
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

(lambda utils.run-on-children-top-down [widget to-be-run ?arguments]
  (var stop false)
  (when (not ?arguments)
    (var ?arguments {}))
  (when (widget.get-enabled)
    (set stop (to-be-run widget (unpack ?arguments))))
  (each [k v (pairs (widget.get-children))]
    (when (not stop)
      (set stop (or stop (utils.run-on-children-top-down v to-be-run ?arguments)))))
  stop)

(lambda utils.run-on-children-down-top [widget to-be-run ?arguments]
  (when (not ?arguments)
    (var ?arguments {}))
  (var stop false)
  (each [k v (pairs (widget.get-children))]
    (when (not stop)
      (set stop (or stop (utils.run-on-children-down-top v to-be-run ?arguments)))))
  (when (and (not stop) (widget.get-enabled))
    (set stop (or stop (to-be-run widget (unpack arguments)))))
  stop)

utils
