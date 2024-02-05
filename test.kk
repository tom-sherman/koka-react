fun f(x=0)
  x

fun g(x: ?int)
  f(x)

fun main()
  println(g())
