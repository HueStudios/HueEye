(fn base [?parent]
  (var base-widget {:_parent nil :_children {} :_id nil})
  (fn base-widget.get-parent []
    base-widget._parent)
  (lambda base-widget.set-parent [parent]
    (set base-widget._parent parent)
    (: (base-widget.get-parent) :add-child base-widget))
  (lambda base-widget.set-children [children]
    (set base-widget._children children))
  (fn base-widget.get-children []
    base-widget._children)
  (fn base-widget.get-id []
    base-widget._id)
  (lambda base-widget.set-id [new-id]
    (set base-widget._id new-id))
  (lambda base-widget.add-child [child]
    (tset (base-widget.get-children) (child.get-id) child))
  (lambda base-widget.remove-child [child]
    (tset (base-widget.get-children) (child.get-id) nil))

  (when (or (not ?parent) (not ?parent.master))
    (local widget-manager (require :hueeye.widget-manager))
    (if ?parent
      (base-widget.set-parent ?parent)
      (base-widget.set-parent (widget-manager.get-master-widget)))
    (base-widget.set-id (widget-manager.add-widget base-widget)))
  base-widget)
