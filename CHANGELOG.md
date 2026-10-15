# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2026-10-15

A rewrite. Version 1.0.0 described a modular framework (AI routing, analytics, security,
networking, storage, UI modules) whose sources were placeholders; in June 2026 they were
consolidated into a few stubs, including an Apple Pay wrapper that approved every payment and a
command-line tool that printed random sizes. This release replaces all of it with code built on
Apple's App Clip documentation. Nothing from 1.0.0's API remains.

### Added

- `Invocation`: validates the invocation URL from `NSUserActivityTypeBrowsingWeb` (https only,
  a host, at most 2,048 bytes, 32 path components and 64 query items, no `.` or `..`
  components, no control or format characters in the decoded host, path or query),
  percent-decodes path and query, and recognizes default App Clip links
  (`https://appclip.apple.com/id?p=<bundle ID>`, with `p` checked as a bundle identifier).
  `InvocationLimits` and `InvocationError`.
- `InvocationRouter`, `RoutePattern` and `RouteMatch`: patterns such as `/order/:id`, `/shop/*`
  and `host/path`, tried from the most specific prefix, with handlers that can decline a match
  and a fallback. `RouteMatch.integer(_:)` and `queryInteger(_:)` never trap.
- `LastInvocationStore` for launches without a URL, and `View.onInvocation(limits:perform:rejected:)`.
- `SizeBudget`, `ThinningReport` and `BundleSizeScanner`: Apple's per-variant App Clip size
  limits applied to Xcode's `App Thinning Size Report.txt` or to a built `.app` folder.
- `AppClipCodeURLCheck`: Apple's rules for URLs in App Clip Codes, as errors and suggestions.
- `AppIdentifier`, `AssociatedDomain`, `AssociationFile` and `AssociationFileValidator`:
  entitlement entries and `apple-app-site-association` files for App Clips and their full app.
- `HandoffStore`: a versioned, expiring, size-limited `Codable` value shared with the full app
  through an App Group.
- `ExpectedLocation`, `LocationConfirmation` and `APActivationPayload.confirm(_:)` for location
  confirmation; `View.fullAppOverlay(isPresented:position:)` for the App Store overlay.
- The `appclipstudio` command-line tool: `size`, `check-url`, `check-domain`, `aasa validate`
  and `aasa generate`, each with `--json` and exit codes for CI.
- `Examples/CoffeeShop`: an app and its App Clip built from shared sources.
- DocC documentation with the articles Getting Started, Routing Invocations, Checking App Clip
  Size, Associating Your Website and Handing Off to the Full App.

### Changed

- Minimum platforms are iOS 16 and macOS 13; the package uses Swift tools 6.2 and the Swift 6
  language mode.

### Removed

- All 1.0.0 modules and the June 2026 stubs: `AppClipCore`, `AppClipRouter`,
  `AppClipAnalytics`, `AppClipUI`, `AppClipNetworking`, `AppClipStorage`, `AppClipSecurity`,
  `AppClipTesting`, `UniversalLinkRouter`, `ZeroFrictionApplePay`, `LiveActivityAdapter` and
  `AppClipConversion`.
- The CocoaPods podspec, which was never published.

## [1.0.0] - 2026-02-02

First tagged release. Its modules were placeholders and are not supported; use 2.0.0.

[Unreleased]: https://github.com/muhittincamdali/AppClipsStudio/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/muhittincamdali/AppClipsStudio/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/muhittincamdali/AppClipsStudio/releases/tag/v1.0.0
