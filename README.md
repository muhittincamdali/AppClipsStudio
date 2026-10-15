<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-light.svg" alt="AppClipsStudio: Invocation routing, size checks and website association for iOS App Clips."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="CI status"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="Latest version: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="Supported platforms: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="Language version: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="License: MIT"></picture></a>
</p>

<p align="center">
<a href="#quick-start"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-en-light.svg" alt="Get started"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-en-light.svg" alt="Documentation"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-en-light.svg" alt="Examples"></picture></a>
</p>

<!-- brand:end -->

A Swift package for iOS App Clips and the apps they belong to. It validates the invocation URL
the system passes at launch and routes it to your screens the way App Store Connect routes it to
App Clip experiences, confirms the person is where the code is, and hands the App Clip's data to
the full app. Its `appclipstudio` command-line tool checks what App Store Connect and the system
will check before you upload: each variant's size, App Clip Code URLs, the
`apple-app-site-association` file and Associated Domains entries. The package has no
dependencies.

## Highlights

- **Invocation routing with Apple's matching rule** — patterns such as `/table/:number` and
  `/shop/*`; the most specific prefix wins, as in App Store Connect, and a fallback covers the
  rest of a registered prefix, which Apple requires an App Clip and its full app to handle.
  Default App Clip links (`https://appclip.apple.com/id?p=…`) are recognized.
- **Untrusted input stays bounded** — invocation URLs are checked for scheme, host, length,
  path and query size, and `.`/`..` components before your code sees them; numbers parse
  without trapping; size reports reject `nan`, `inf` and `1e999`; files are read with a limit;
  the folder scan doesn't follow symbolic links; output never echoes control characters.
- **Size checks per variant** — Apple's 10, 15 and 100 MB limits applied to each variant of
  Xcode's `App Thinning Size Report.txt` by iOS version, deployment target and invocation type,
  with an exit status for CI.
- **Website association** — generate and validate `apple-app-site-association`, check
  `appclips:`/`applinks:` entitlement entries, and lint App Clip Code URLs against Apple's
  encoding rules.
- **The moment after the task** — location confirmation with a validated 500 m region, the App
  Store overlay for the full app, and `HandoffStore`, which passes a versioned, expiring,
  size-limited value to the full app through the shared App Group.
- **Tested** — 111 Swift Testing tests run on macOS and an iPhone simulator, including the edge
  cases above and the quick start below.
- **An example that builds** — [Examples/CoffeeShop](Examples/CoffeeShop) is an app and its App
  Clip from the same sources; CI builds it, and the Usage samples are copied from it.

## Quick start

**1. Add the package**

In Xcode, choose **File › Add Package Dependencies…** and enter the repository URL:

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

Leave **Dependency Rule** at **Up to Next Major Version** from `2.0.0` and click **Add
Package**. In the next window, choose your App Clip target next to **AppClipsStudio** and click
**Add Package** again. (If your project has no App Clip yet, add one with **File › New ›
Target… › App Clip**; add the package to the full app target too.)

**2. Route the invocation**

Replace everything in the App Clip's `ContentView.swift` with:

```swift
import AppClipsStudio
import SwiftUI

enum Screen: Equatable {
    case welcome
    case table(Int)
}

struct ContentView: View {
    @State private var screen = Screen.welcome

    var body: some View {
        Group {
            switch screen {
            case .welcome: Text("Scan a table tag")
            case .table(let number): Text("Table \(number)")
            }
        }
        .font(.largeTitle)
        .onInvocation { invocation in
            screen = (try? Self.router.route(invocation)) ?? .welcome
        }
    }

    static let router: InvocationRouter<Screen> = {
        var router = InvocationRouter<Screen>()
        try? router.add("/table/:number") { match in
            match.integer("number").map(Screen.table)
        }
        router.fallback { _ in .welcome }
        return router
    }()
}
```

**3. Run it with an invocation URL**

Choose **Product › Scheme › Edit Scheme…**, select **Run › Arguments**, and set the
`_XCAppClipURL` environment variable (Xcode adds it to every App Clip scheme) to
`https://appclip.example.com/table/12`. Choose an iPhone simulator and press **Run** (⌘R). The
App Clip shows "Table 12"; with `/table/twelve` or no path it shows "Scan a table tag".

The same code is compiled and tested in
[`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift).

## Installation

### Swift Package Manager

Add the library to your App Clip and full app targets in Xcode as in the quick start, or in
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/AppClipsStudio.git", from: "2.0.0")
],
targets: [
    .target(name: "YourAppFeature", dependencies: [
        .product(name: "AppClipsStudio", package: "AppClipsStudio")
    ])
]
```

### Command-line tool

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

Version 2.0.0 (October 2026) is the first release of this code. The earlier release, 1.0.0
(February 2026), described modules that were never implemented; in June 2026 they were reduced
to stubs, and in October 2026 the package was rewritten from Apple's App Clip documentation.
[CHANGELOG.md](CHANGELOG.md) lists what changed.

## Usage

The samples below are copied from the example app in
[`Examples/CoffeeShop`](Examples/CoffeeShop), which CI builds.

### Routes

From [`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift): a table tag,
a poster code and the default App Clip link, with the menu for every other URL.

```swift
var router = InvocationRouter<CoffeeScreen>(
    allowedHosts: ["appclip.example.com", "example.com", Invocation.defaultLinkHost]
)
try router.add("/table/:number") { match in
    guard let number = match.integer("number"), (1...99).contains(number),
          let store = match.queryInteger("p").flatMap(Catalog.store(id:)) else { return nil }
    return .table(store, number: number)
}
try router.add("/order") { match in
    match.queryInteger("p").flatMap(Catalog.drink(id:)).map(CoffeeScreen.drink)
}
try router.add("appclip.apple.com/id") { match in
    match.queryInteger("drink").flatMap(Catalog.drink(id:)).map(CoffeeScreen.drink)
}
router.fallback { _ in .menu }
```

A handler that returns `nil` (an unknown store, a table number out of range) lets the next
route try, and finally the fallback.

### Launches without a URL

From [`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift). A person who
returns from a notification or the App Switcher launches the App Clip without a URL, so each
invocation is saved and restored:

```swift
func handle(_ invocation: Invocation) {
    do {
        screen = try router.route(invocation) ?? .menu
        lastInvocation.save(invocation)
        rejection = nil
    } catch {
        rejection = error
    }
}
```

### Location confirmation and the App Store overlay

From [`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift), App Clip only (the
`APPCLIP` compilation condition):

```swift
.onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
    guard let invocation = try? Invocation(userActivity: activity) else { return }
    model.handle(invocation)
    if let payload = activity.appClipActivationPayload {
        Task { await model.confirmLocation(with: payload) }
    }
}
.fullAppOverlay(isPresented: $model.showsFullAppOverlay)
```

```swift
func confirmLocation(with payload: APActivationPayload) async {
    guard case .table(let store, _) = screen else { return }
    confirmation = await payload.confirm(store.location)
}
```

Each store's `location` is an `ExpectedLocation`, which only accepts finite coordinates in
range and a radius greater than 0 and at most 500 meters, Apple's limit.

### Handing the order to the full app

```swift
func placeOrder() {
    var order = PlacedOrder(drinkIDs: cart.map(\.id), placedAt: Date())
    if case .table(let store, let number) = screen {
        order.storeID = store.id
        order.table = number
    }
    try? handoff?.save(order, expiresAfter: 30 * 24 * 60 * 60)
    placedOrder = order
    cart = []
    #if APPCLIP
    showsFullAppOverlay = true
    #endif
}

/// In the full app: takes the order the App Clip left, once.
func importHandoff() {
    importedOrder = try? handoff?.take()
}
```

`handoff` is a `HandoffStore<PlacedOrder>` on the App Group's `UserDefaults` suite, shared by
both targets.

## Command-line tool

Check every variant of an exported App Clip (the exit status is 1 when one is over its limit):

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

Check URLs for App Clip Codes:

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

Generate and validate the association file, and check entitlement entries:

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

Every command takes `--json`. `appclipstudio help` lists the options.

## Demo

The example App Clip opened with a table tag URL and a poster URL:

| Table tag (light)                                       | Table tag (dark)                                      | Poster (light)                                         | Poster (dark)                                        |
| ------------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------ | ---------------------------------------------------- |
| ![Table 12 at Harbor Street, light](docs/images/table-light.png) | ![Table 12 at Harbor Street, dark](docs/images/table-dark.png) | ![Flat White poster offer, light](docs/images/poster-light.png) | ![Flat White poster offer, dark](docs/images/poster-dark.png) |

The screenshots are captured on an iPhone simulator by
[`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh). In the simulator the
system passes no activation payload, so the badge reads "Location not checked on this launch".

To try it yourself, open `CoffeeShop.xcodeproj` in [`Examples/CoffeeShop`](Examples/CoffeeShop),
choose the **CoffeeShopClip** scheme and an iPhone simulator, and press **Run**.
[Examples/README.md](Examples/README.md) has the details.

## Documentation

- [API reference](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  (DocC, published to GitHub Pages from `master`)
- Build it locally in Xcode with **Product › Build Documentation**, or from the command line:

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## Guides

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — add the package to both targets, route the invocation and test it
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md)).
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — what is checked, the pattern syntax and which route wins
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md)).
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — Apple's limits, the size report and the `size` command
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md)).
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — entitlement entries, `apple-app-site-association` and App Clip Code URLs
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md)).
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — location confirmation, the App Store overlay, notifications and `HandoffStore`
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md)).

## Requirements

| Platform  | Minimum version                                             |
| --------- | ----------------------------------------------------------- |
| iOS       | 16 (location confirmation and the overlay are iOS only)     |
| macOS     | 13 (the command-line tool and the platform-neutral checks)  |
| Toolchain | Swift 6.2 · Xcode 26+                                       |

CI builds with the default Xcode of GitHub's `macos-26` runner image. The package is developed
with Xcode 27. The example app targets iOS 17.

## Architecture

- `Sources/AppClipsStudio` is the library, one folder per task: `Invocation`, `Routing`,
  `Size`, `AppClipCode`, `Association`, `Handoff`, `Location` and `Promotion`. Everything except
  the SwiftUI modifiers and the `APActivationPayload` extension is value types and pure
  functions, so it runs and is tested on macOS too.
- Errors are typed (`throws(InvocationError)`, `throws(ThinningReportError)`, …) so callers can
  switch over every case.
- `Sources/AppClipsStudioTool` holds the command-line tool's commands as a library, so the tests
  call them directly; `Sources/appclipstudio` only forwards the arguments.
- CI runs `swift test` on macOS and `xcodebuild test` on an iPhone simulator, builds the example
  app and publishes the DocC documentation.

Run the tests locally:

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Roadmap

- Add the package to the Swift Package Index; `.spi.yml` is already in the repository.
- Read sizes from an exported `.ipa` directly, without the size report.
- An App Clip experience list for the App Store Connect API (advanced experiences per location).

## Contributing

Contributions are welcome. Read the [contributing guide](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md) and the [code of conduct](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) before opening a pull request. Report security issues privately as described in the [security policy](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## License

Released under the MIT license. See [LICENSE](LICENSE).
