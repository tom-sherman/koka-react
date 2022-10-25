# koka-react

An experiment in building a [React](https://github.com/facebook/react)-like UI library in Koka.

Right now it can only construct an element tree and render it to a string, not much but it's a start. See my Twitter thread for a rough design on how I expect this all to work: https://twitter.com/tomus_sherman/status/1582508438789447680

Here's the current proposed API, it's analogous to React.js in the following ways:

- Hooks are replaced with algebraic effects, this remove many annoyances with React Hooks, namely they can be called conditionally, in loops, and not just at the top level
- `useState` is replaced with the `state()` function and associated effect, it returns a state value that can be `get()` and `set()`.
- `useEffect` is replaced with the `defer()` function and associated effect. Naming comes from [this great article on algebraic effects](https://blog.reesew.io/algebraic-effects-for-react-developers), called so because the effect inside is deferred until after rendering. `useLayoutEffect` would probably be `immediate()` or something.
- JSX is replaced with bare function calls
- Child elements are constructed in a `children` lambda. This allows for standard control flow (if/else, while loops, etc) instead of being forced into using expressions.

## Example

This is proposed syntax/api, ofc subject to change.

```koka
fun counter()
  val count = state(0)

  // Dependency array comes first so that we can take advantage of trailing lambdas
  defer(state.get) {
    println("Count is: " ++ state.get)
  }

  div(children={
    button(html-type="button", on-click={ count.set(count.get + 1) }, children={
      text("Increment")
    })

    button(html-type="button", on-click={ count.set(count.get - 1) }, children={
      text("Decrement")
    })

    if (count.get == 0) {
      // A hook inside children, conditional, and not at the top level! Awesome!
      defer(state.get) {
        alert("Zero count!")
      }

      p(class="empty", children={ text("No count") })
    } else {
      p(class="text", children={ count.get.text })
    }
  })
```

### What about fetching and suspense?

Some very interesting possibilities here, for example how about fetching and suspending in the same component:

```koka
fun user-avatar(id)
  div(class="user-avata-card", children={
    suspense(fallback=spinner(), children={
      let user = fetchUser(id)

      img(href=user.avatar.url)
    })
  })
```

What's great is that fetchUser would have a signature like `(id: string) fetch -> user`. That fetch effect is crucial because it means we can have type-safe suspense boundaries.
