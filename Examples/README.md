# Examples

## CoffeeShop

An iOS app with an App Clip, both built from the same `Shared` sources, as Apple recommends.
It uses the package from this checkout (a local package reference to `../..`), so it always
shows the current code.

| Target           | What it shows                                                                                                                         |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `CoffeeShopClip` | Routing invocation URLs to screens, location confirmation for table tags, saving the order for the full app and the App Store overlay |
| `CoffeeShop`     | The full app: it handles the same URLs with `onInvocation(perform:)` and imports the App Clip's order once with `HandoffStore.take()` |

The routes in [`Shared/CoffeeRoutes.swift`](CoffeeShop/Shared/CoffeeRoutes.swift):

| Invocation URL                                                                     | Screen              |
| ---------------------------------------------------------------------------------- | ------------------- |
| `https://appclip.example.com/table/12?p=1`                                         | Table 12 in store 1 |
| `https://appclip.example.com/order?p=3`                                            | Drink 3 highlighted |
| `https://appclip.apple.com/id?p=io.github.muhittincamdali.CoffeeShop.Clip&drink=3` | Drink 3 highlighted |
| Any other URL on `appclip.example.com` or `example.com`                            | The menu            |

The App Clip-only code (location confirmation and the overlay) is behind the `APPCLIP` active
compilation condition, which only the App Clip target sets.

Run it:

1. Open `Examples/CoffeeShop/CoffeeShop.xcodeproj` in Xcode 26 or later.
2. Choose the **CoffeeShopClip** scheme and an iPhone simulator. The scheme sets the
   `_XCAppClipURL` environment variable to `https://appclip.example.com/table/12?p=1`; change it
   in **Product › Scheme › Edit Scheme… › Run › Arguments** to try another URL.
3. Press **Run** (⌘R).

The simulator needs no signing. To run on a device, set your team in **Signing & Capabilities**
for both targets and replace the App Group and associated domains with your own.

From the command line:

```sh
cd Examples/CoffeeShop
xcodebuild build -scheme CoffeeShop -destination 'generic/platform=iOS Simulator'
```

[`scripts/capture-screenshots.sh`](../scripts/capture-screenshots.sh) builds the example, opens
the App Clip with two invocation URLs through the DEBUG-only `-demoURL` launch argument and
saves the screenshots in `docs/images`.

The project file is made with [XcodeGen](https://github.com/yonaskolb/XcodeGen) from
[`project.yml`](CoffeeShop/project.yml) and committed, so you only need XcodeGen after editing
`project.yml`.
