# Getting Started

Add the package to an App Clip and its full app, open the right screen for each invocation URL
and restore the last one when a launch has no URL.

## Overview

App Clips and their full app share code, usually through a Swift package. Add AppClipsStudio
to both targets, then route the invocation URL in code that both targets compile: once the full
app is installed, it replaces the App Clip and receives every invocation in its place.

### Add the package

In Xcode, choose **File › Add Package Dependencies…**, enter
`https://github.com/muhittincamdali/AppClipsStudio.git` and add the **AppClipsStudio** library
to the App Clip target and to the full app target.

### Describe your invocation URLs

Write one enum for the screens an invocation can open, and a router that maps URLs to it.
Register the hosts of your App Clip experiences; invocations from other hosts are rejected.

```swift
import AppClipsStudio

enum Screen: Hashable {
    case menu
    case table(Int)
}

func makeRouter() throws -> InvocationRouter<Screen> {
    var router = InvocationRouter<Screen>(allowedHosts: ["appclip.example.com"])
    try router.add("/table/:number") { match in match.integer("number").map(Screen.table) }
    router.fallback { _ in .menu }
    return router
}
```

Apple requires the App Clip and the full app to handle every URL under a registered prefix, so
the fallback opens the menu for anything the routes don't cover. See <doc:RoutingInvocations>
for the pattern syntax and how the router picks a route.

### Handle the invocation

Attach ``SwiftUICore/View/onInvocation(limits:perform:rejected:)`` to the root view of both
targets. It validates the activity's URL before calling you.

```swift
struct RootView: View {
    @State private var screen = Screen.menu
    private let router = try! makeRouter()
    private let lastInvocation = LastInvocationStore()

    var body: some View {
        ScreenView(screen: screen)
            .onInvocation { invocation in
                screen = (try? router.route(invocation)) ?? .menu
                lastInvocation.save(invocation)
            }
            .task {
                if let invocation = lastInvocation.load() {
                    screen = (try? router.route(invocation)) ?? .menu
                }
            }
    }
}
```

When a person returns to the App Clip from a notification or the App Switcher, the system
launches it without an invocation URL. ``LastInvocationStore`` keeps the last URL for that case
and validates it again when it loads it.

### Test an invocation

Xcode adds the `_XCAppClipURL` environment variable to the App Clip's scheme. Set it to an
invocation URL, such as `https://appclip.example.com/table/12`, and run the App Clip: it
launches with that URL in its user activity. To see the App Clip card, register a local
experience on a device in **Settings › Developer › Local Experiences**.

### Next steps

- Check each variant's size before you upload: <doc:CheckingAppClipSize>.
- Associate the App Clip with your website and check App Clip Code URLs:
  <doc:AssociatingYourWebsite>.
- Pass the App Clip's data to the full app and confirm the person's location:
  <doc:HandingOffToTheFullApp>.
