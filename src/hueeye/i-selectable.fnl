(local utils (require :hueeye.utils))
(local i-actionable (require :hueeye.i-actionable))

(lambda i-selectable [target]
  (when (not target.is-actionable)
    (i-actionable target))
  (set target._selected false)
  (fn target.get-selected []
    target._selected)
  (fn target.on-select [])
  (fn target.on-deselect [])
  (lambda target.set-selected [selected]
    (when (and (not (target.get-selected)) selected)
      (target.on-select))
    (when (and (target.get-selected) (not selected))
      (target.on-deselect))
    (set target._selected selected))
  (fn on-action []
    (target.set-selected true))
  (set target.on-action (utils.decorate-after target.on-action on-action))
  (fn on-global-mouse-up [gx gy x y]
    (when (not (target.is-inside? gx gy))
      (target.set-selected false)))
  (set target.on-global-mouse-up (utils.decorate-after target.on-global-mouse-up on-global-mouse-up))
  (set target.is-selectable true))
