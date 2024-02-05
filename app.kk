import react
import react-dom

fun app()
  view {
    view {
      text("hello")
    }
    view {
      text("world")
    }
  }

fun main()
  render-to-string(app).println
