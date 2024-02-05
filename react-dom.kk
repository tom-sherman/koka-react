import react

fun collect(action)
  var nodes := []
  with handler
    return(x) nodes.reverse
    fun render(el) nodes := Cons(el, nodes)
  action()

fun render-element-to-string(element)
  match element.node
    View -> "<div>" ++ join(map(element.children, render-element-to-string)) ++ "</div>"
    Text(text) -> text

pub fun render-to-string(children)
  val nodes = collect(children)
  nodes.map(render-element-to-string).join("")
