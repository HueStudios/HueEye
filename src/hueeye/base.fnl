(fn base [?parent]
  (var base-widget {:_parent nil :_children {} :_id nil})
  (fn base-widget.get-parent []
    base-widget._parent)
  (lambda base-widget.set-parent [parent]
    (print (.. "Trying to set parent " (parent.get-id) " on " (base-widget.get-id)))
    (when (base-widget.get-parent)
      (local current-parent (base-widget.get-parent))
      (current-parent.remove-child base-widget))
    (set base-widget._parent parent)
    (parent.add-child base-widget))
  (lambda base-widget.set-children [children]
    (set base-widget._children children))
  (fn base-widget.get-children []
    base-widget._children)
  (fn base-widget.get-id []
    base-widget._id)
  (lambda base-widget.set-id [new-id]
    (set base-widget._id new-id))
  (lambda base-widget.add-child [child]
    (local widget-manager (require :hueeye.widget-manager))
    (print (.. "Trying to add child " (child.get-id)))
    (when (not (= child (widget-manager.get-master-widget)))
      (print (.. "Added child " (child.get-id)))
      (tset (base-widget.get-children) (child.get-id) child)))
  (lambda base-widget.remove-child [child]
    (tset (base-widget.get-children) (child.get-id) nil))

  (when (or (not ?parent) (not ?parent.master))
    (local widget-manager (require :hueeye.widget-manager))
    (widget-manager.add-widget base-widget))
  (when (and ?parent (not ?parent.master))
    (base-widget.set-parent ?parent))
  base-widget)
