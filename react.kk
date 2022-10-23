struct element
  kind : string
  children: list<element>

effect fun el( el : element ) : ()

fun button( html-type: string, on-click: () -> e () ,children: () -> el () )
  Element(
    "button",
    collect(children)
  ).el

fun div( class: ?string, children: () -> el () )
  Element(
    "div",
    collect(children)
  ).el

fun p( class: ?string, children: () -> el () )
  Element(
    "div",
    collect(children)
  ).el

fun text( text : string )
  Element(
    "_TEXT_ELEMENT",
    []
  ).el

fun collect ( children: () -> el () ) : list<element>
  var els : list<element> := []
  handle children
    fun el(x) els := els ++ [x]

  els

fun show(element: element) : pure string
  element.kind ++ "->" ++ element.children.show-list(show)

fun render-to-string(children: () -> el ()) : pure string
  collect(children).show-list(show)
