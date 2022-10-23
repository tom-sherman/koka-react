import react

fun app()
  div(children={
    button(html-type="button", on-click={ print("clicked!") }, children={
      text(text="Click me")
    })

    p(class="text", children={
      button(html-type="button", on-click={ print("clicked!") }, children={
        text(text="Click me")
      })
    })
  })

fun main()
  render-to-string({ app() }).println
