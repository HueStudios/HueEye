(local drawable (require :hueeye.drawable))
(lambda bound [x y ?parent]
  (local bound-widget (drawable x y ?parent))
  (lambda bound-widget.is-inside? [x y]
    false)
  bound-widget)
