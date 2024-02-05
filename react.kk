module react

pub effect fun render( el : element ) : ()

pub ref type node
  View
  Text(text: string)

pub struct element
  node: node
  children: list<element>


fun view-impl( children )
  var nodes := []
  with handler
    return(x) Element(node=View, children=nodes.reverse)
    fun render(el) nodes := Cons(el, nodes)
  children()

pub fun view(children) render(view-impl(children))

pub fun text( text: string )
  render(Element(node=Text( text=text ), children=[]))
