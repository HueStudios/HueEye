(local widget-manager {})
(local utils (require :utils))

;; Private

(local ID-LENGTH 8)
(var widgets {})

(var widget-pipeline {})

(lambda verify-id [id]
  (var to-return true)
  (when (. widgets id)
    (set to-return false))
  to-return)

(fn generate-valid-id []
  (var new-id (utils.get-random-string ID-LENGTH))
  (when (not (verify-id new-id))
    (set new-id (generate-valid-id)))
  new-id)

(lambda run-on-children-top-down [widget to-be-run]
  (var stop (to-be-run widget))
  (each [k v (pairs (widget.get-children))]
    (when (not stop)
      (set stop (or stop (run-on-children v to-be-run)))))
  stop)

(lambda run-on-children-down-top [widget to-be-run]
  (var stop false)
  (each [k v (pairs (widget.get-children))]
    (when (not stop)
      (set stop (or stop (run-on-children v to-be-run)))))
  (set stop (or stop (to-be-run widget)))
  stop)

;; Public

(lambda widget-manager.add-widget [widget]
  (when (= nil (widget.get-id))
    (local this-widget-id (generate-valid-id))
    (tset widgets this-widget-id widget)
    this-widget-id))

(lambda widget-manager.remove-widget [widget]
  (local this-widget-id (widget.get-id))
  (when (. widgets this-widget-id)
    (tset widgets this-widget-id nil)
    (each [k v (pairs (widget.get-children))]
      (widget-manager.remove-widget v))))

(lambda widget-manager.add-to-pipeline [function]
  (tset widget-pipeline (+ 1 (# widget-pipeline)) function))

(fn widget-manager.widget-pipeline [])
