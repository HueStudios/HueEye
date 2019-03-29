(local drawable (require :hueeye.drawable))
(lambda bound [x y ?parent ?color]
  (local bound-widget (drawable x y ?parent ?color))
  (lambda bound-widget.is-inside? [x y]
    false)
  bound-widget)
