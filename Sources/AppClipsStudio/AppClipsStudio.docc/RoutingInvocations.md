# Routing Invocations

Map invocation URLs to screens with the same most-specific-prefix rule that App Store Connect
uses for App Clip experiences.

## Overview

App Store Connect matches an invocation URL against the URLs of your advanced App Clip
experiences and picks the one with the most specific matching prefix. Apple recommends
registering few, generic URLs and reading the rest of the URL in code. ``InvocationRouter`` is
that code: it validates the URL, finds the most specific route and gives your handler the
captured values.

### What gets checked first

Every URL becomes an ``Invocation`` before a route sees it. The URL must use `https`, have a
host, and stay within ``InvocationLimits`` (2,048 bytes, 32 path components and 64 query items
by default). A path component that is `.` or `..` or not valid percent-encoding is rejected.
With `allowedHosts`, other hosts throw ``InvocationError/hostNotAllowed(_:)``.

Path components and query values arrive percent-decoded. An encoded slash stays in its
component: `/shop/a%2Fb` has the components `shop` and `a/b`.

### Patterns

| Pattern                             | Matches                    | Captures               |
| ----------------------------------- | -------------------------- | ---------------------- |
| `/menu`                             | `/menu` only               | nothing                |
| `/order/:id`                        | `/order/42`                | `id` = `42`            |
| `/shop/*`                           | `/shop`, `/shop/mugs/blue` | ``RouteMatch/remainder`` |
| `appclip.example.com/table/:number` | that host only             | `number`               |

Literal components are case-sensitive, like URL paths; hosts are not.

### Which route wins

The router tries routes from the most to the least specific, whatever order you add them in:

1. More path components first (a longer prefix).
2. Then more literal components (`/menu/today` before `/menu/:section`).
3. Then exact patterns before `/*` patterns.
4. Then patterns with a host before patterns without one.
5. Equal routes keep the order you added them in.

A handler can return `nil` to decline a match, for example when an identifier is not a number
or not in your catalog. The router then tries the next route, and finally the fallback.

```swift
try router.add("/order") { match in
    match.queryInteger("p").flatMap(Catalog.drink(id:)).map(Screen.drink)
}
```

``RouteMatch/integer(_:)`` and ``RouteMatch/queryInteger(_:)`` accept an optional `-` followed
by ASCII digits and return `nil` for anything else, including values that don't fit in `Int`, so
a URL can't make the App Clip trap.

### Default App Clip links

App Store Connect generates a default App Clip link for every App Clip:
`https://appclip.apple.com/id?p=<bundle ID>&key=value`. ``Invocation`` reports the bundle ID as
``Invocation/defaultLinkBundleIdentifier`` and leaves `p` out of
``Invocation/queryItems``, so only your launch parameters remain. Route it like any other URL:

```swift
var router = InvocationRouter<Screen>(allowedHosts: ["appclip.example.com", Invocation.defaultLinkHost])
try router.add("appclip.apple.com/id") { match in
    match.queryInteger("drink").map(Screen.drink)
}
```

### Launches without a URL

A person who returns to an App Clip from a notification or the App Switcher launches it
without an invocation URL. ``Invocation/init(userActivity:limits:)`` throws
``InvocationError/missingURL`` for such an activity. Save each invocation with
``LastInvocationStore`` and restore it in that case.
