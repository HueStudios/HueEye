(local widget-manager (require :hueeye.widget-manager))
(local utils (require :hueeye.utils))
(var mouse-manager {})
(set mouse-manager.previous-mouse-x 0)
(set mouse-manager.previous-mouse-y 0)
(set mouse-manager.current-mouse-x 0)
(set mouse-manager.current-mouse-y 0)
(set mouse-manager.delta-mouse-x 0)
(set mouse-manager.delta-mouse-y 0)
(set mouse-manager.previous-mouse-buttons {})
(set mouse-manager.current-mouse-buttons {})
(set mouse-manager.blocking-widget nil)
(fn mouse-manager.before-widgets []
  ;TODO Actually obtain the current values for the static properties
  (local (mx my) (love.mouse.getPosition))
  (set mouse-manager.current-mouse-x mx)
  (set mouse-manager.current-mouse-y my)
  (set mouse-manager.current-mouse-buttons {})
  (for [i 1 3]
    (tset mouse-manager.current-mouse-buttons i (love.mouse.isDown i)))
  (set mouse-manager.delta-mouse-x
    (- mouse-manager.current-mouse-x
       mouse-manager.previous-mouse-x))
  (set mouse-manager.delta-mouse-y
    (- mouse-manager.current-mouse-y
       mouse-manager.previous-mouse-y))
  (set mouse-manager.blocking-widget nil))
(fn mouse-manager.widget-step [widget]
  (when widget.is-clickable
    (when (not mouse-manager.blocking-widget)
      (set mouse-manager.blocking-widget widget))
    (local global-x mouse-manager.current-mouse-x)
    (local global-y mouse-manager.current-mouse-y)
    (local previous-x mouse-manager.previous-mouse-x)
    (local previous-y mouse-manager.previous-mouse-y)
    (local local-x (- global-x (widget.get-global-x)))
    (local local-y (- global-y (widget.get-global-y)))
    (local delta-x mouse-manager.delta-mouse-x)
    (local delta-y mouse-manager.delta-mouse-y)
    (local is-inside? (widget.is-inside? global-x global-y))
    (local was-inside? (widget.is-inside? previous-x previous-y))
    ;(print (.. "Stepping mouse management for widget " (widget.get-id)))
    ;(print (.. "Inside? " (tostring is-inside?)))
    (local buttons mouse-manager.current-mouse-buttons)
    (local previous-buttons mouse-manager.previous-mouse-buttons)
    (local block mouse-manager.blocking-widget)
    (when is-inside?
      (when (= block widget)
        (widget.on-mouse-hover
          global-x global-y
          local-x local-y
          delta-x delta-y))
      (widget.on-global-mouse-hover
        global-x global-y
        local-x local-y
        delta-x delta-y)
      (for [i 1 3]
        (local was-pressed? (. previous-buttons i))
        (local is-pressed? (. buttons i))
        (when is-pressed?
          (when (= block widget)
            (widget.on-mouse-drag
              global-x global-y
              local-x local-y
              i
              delta-x delta-y))
          (widget.on-global-mouse-drag
            global-x global-y
            local-x local-y
            i
            delta-x delta-y))
        (when (and (not was-pressed?) is-pressed?)
          (when (= block widget)
            (widget.on-mouse-down
              global-x global-y
              local-x local-y
              i))
          (widget.on-global-mouse-down
            global-x global-y
            local-x local-y
            i))
        (when (and was-pressed? (not is-pressed?))
          (when (= block widget)
            (widget.on-mouse-up
              global-x global-y
              local-x local-y
              i))
          (widget.on-global-mouse-up
            global-x global-y
            local-x local-y
            i))))
    (when (and (not is-inside?) was-inside?)
      (when (= block widget)
        (widget.on-mouse-leave
          global-x global-y
          local-x local-y
          delta-x delta-y))
      (widget.on-global-mouse-leave
        global-x global-y
        local-x local-y
        delta-x delta-y))
    (when (and is-inside? (not was-inside?))
      (when (= block widget)
        (widget.on-mouse-enter
          global-x global-y
          local-x local-y
          delta-x delta-y))
      (widget.on-global-mouse-enter
        global-x global-y
        local-x local-y
        delta-x delta-y))))
(fn mouse-manager.after-widgets []
  (set mouse-manager.previous-mouse-x mouse-manager.current-mouse-x)
  (set mouse-manager.previous-mouse-y mouse-manager.current-mouse-y)
  (set mouse-manager.previous-mouse-buttons mouse-manager.current-mouse-buttons))

(widget-manager.add-to-pipeline mouse-manager.before-widgets mouse-manager.widget-step mouse-manager.after-widgets false)

mouse-manager
