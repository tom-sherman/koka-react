module react

struct element
  kind : string
  children: list<element>

effect fun el( el : element ) : ()

alias children = () -> el ()

pub fun button( html-type: string, on-click: () -> e () , children: children )
  Element(
    "button",
    collect(children)
  ).el

pub fun div( class: ?string, children: children )
  Element(
    "div",
    collect(children)
  ).el

pub fun p( class: ?string, children: children )
  Element(
    "div",
    collect(children)
  ).el

pub fun text( text : string )
  Element(
    "_TEXT_ELEMENT",
    []
  ).el

fun collect ( children: children ) : list<element>
  var els : list<element> := []
  handle children
    fun el(x) els := els ++ [x]

  els

fun show(element: element) : pure string
  element.kind ++ "->" ++ element.children.show-list(show)

pub fun render-to-string(children: children) : pure string
  collect(children).show-list(show)
