(local utils (require :hueeye.utils))

(fn add-masking [target-widget masking-function]
  (when target-widget.draw
    (fn before-drawing []
      (utils.add-mask masking-function)
      (utils.set-mask))
    (fn after-drawing []
      (utils.unset-mask)
      (utils.clear-mask))
    (target-widget.add-before-draw before-drawing)
    (target-widget.add-after-draw after-drawing)))

(fn add-masking-on-children [target-widget masking-function]
  (add-masking target-widget)
  (lambda add-child [child]
    (add-masking-on-children child masking-function))
  (set target.add-child (utils.decorate-after target.add-child add-child))
  (each [k v (pairs (target.get-children))]
    (add-masking-on-children v masking-function)))

(lambda i-mask [target]
  (when target.draw
    (fn target.mask []
      (target.draw))
    (add-masking-on-children target target.mask))) 
