(local widget-manager {})
(local utils (require :hueeye.utils))
(local drawable (require :hueeye.drawable))
(local color-scheme (require :hueeye.color-scheme))

;; Private

(local ID-LENGTH 8)
(local master-widget (drawable 0 0 {:master true} color-scheme.INVISIBLE-COLOR))
(master-widget.set-id :00000000)
(var widgets {:00000000 master-widget})

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



;; Public

(fn widget-manager.get-master-widget []
  (local master-widget (. widgets :00000000))
  master-widget)

(lambda widget-manager.add-widget [widget]
  (when (= nil (widget.get-id))
    (local this-widget-id (generate-valid-id))
    (tset widgets this-widget-id widget)
    (local master-widget (widget-manager.get-master-widget))
    (widget.set-id this-widget-id)
    (widget.set-parent master-widget)))

(lambda widget-manager.remove-widget [widget]
  (local this-widget-id (widget.get-id))
  (when (. widgets this-widget-id)
    (tset widgets this-widget-id nil)
    (each [k v (pairs (widget.get-children))]
      (widget-manager.remove-widget v))))

(lambda widget-manager.add-to-pipeline [pipeline-before pipeline-step pipeline-after top-down update]
  (local pipeline-data {:top-down top-down :to-run pipeline-step :before pipeline-before :after pipeline-after :update update})
  (tset widget-pipeline (+ 1 (# widget-pipeline)) pipeline-data))

(fn widget-manager.widget-pipeline [update]
  (each [k v (ipairs widget-pipeline)]
    (when (= v.update update)
      (v.before)))
  (each [k v (ipairs widget-pipeline)]
    (when (= v.update update)
      (if v.top-down
        (utils.run-on-children-top-down (widget-manager.get-master-widget) v.to-run)
        (utils.run-on-children-down-top (widget-manager.get-master-widget) v.to-run))))
  (each [k v (ipairs widget-pipeline)]
    (when (= v.update update)
      (v.after))))
widget-manager
