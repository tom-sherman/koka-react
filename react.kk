module react

struct element
  kind : string
  children: list<element>

effect fun render( el : element ) : ()

alias children = () -> render ()

pub fun button( html-type: string, on-click: () -> e () , children: children )
  Element(
    "button",
    collect(children)
  ).render

pub fun div( class: ?string, children: children )
  Element(
    "div",
    collect(children)
  ).render

pub fun p( class: ?string, children: children )
  Element(
    "div",
    collect(children)
  ).render

pub fun text( text : string )
  Element(
    "_TEXT_ELEMENT",
    []
  ).render

fun collect ( children: children ) : list<element>
  var els : list<element> := []
  handle children
    fun render(x) els := els ++ [x]

  els

fun show(element: element) : pure string
  element.kind ++ "->" ++ element.children.show-list(show)

pub fun render-to-string(children: children) : pure string
  collect(children).show-list(show)
