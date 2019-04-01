(local utils (require :hueeye.utils))

(lambda add-masking [target-widget masking-function]
  (when target-widget.draw
    (fn before-drawing []
      (utils.add-mask masking-function)
      (utils.set-mask))
    (fn after-drawing []
      (utils.unset-mask)
      (utils.clear-mask))
    (target-widget.add-before-draw before-drawing)
    (target-widget.add-after-draw after-drawing)))

(lambda add-masking-on-children [target-widget masking-function]
  (when (not (= target-widget.mask masking-function))
    (add-masking target-widget masking-function))
  (lambda add-child [child]
    (add-masking-on-children child masking-function))
  (set target-widget.add-child (utils.decorate-after target-widget.add-child add-child))
  (each [k v (pairs (target-widget.get-children))]
    (add-masking-on-children v masking-function)))

(lambda i-mask [target]
  (when target.draw
    (set target.mask target.draw)
    (add-masking-on-children target target.mask)))
