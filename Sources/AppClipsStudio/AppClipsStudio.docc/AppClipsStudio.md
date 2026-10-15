# ``AppClipsStudio``

Route App Clip invocations, check sizes, URLs and association files against Apple's rules,
confirm locations and hand data to the full app.

## Overview

An App Clip lives on what the system passes it at launch: an invocation URL from an App Clip
Code, an NFC tag, a QR code, Messages or a website. AppClipsStudio validates that URL and maps it
to your screens the way App Store Connect maps it to App Clip experiences, then helps with the
rest of the App Clip's short life: confirming the person is where the code is, recommending the
full app, and passing what they did to the full app once it replaces the App Clip.

Before you ship, the same package checks what App Store Connect and the system will check:
each variant's size against Apple's limit, URLs against the App Clip Code rules, and the
`apple-app-site-association` file and Associated Domains entries. The `appclipstudio`
command-line tool runs these checks in CI.

```swift
var router = InvocationRouter<Screen>(allowedHosts: ["appclip.example.com"])
try router.add("/table/:number") { match in match.integer("number").map(Screen.table) }
router.fallback { _ in .menu }

RootView()
    .onInvocation { invocation in
        screen = (try? router.route(invocation)) ?? .menu
    }
```

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:RoutingInvocations>

### Invocations

- ``Invocation``
- ``InvocationLimits``
- ``InvocationError``
- ``LastInvocationStore``

### Routing

- ``InvocationRouter``
- ``RouteMatch``
- ``RoutePattern``
- ``RoutePatternError``

### App Clip size

- <doc:CheckingAppClipSize>
- ``SizeBudget``
- ``SizeBudgetError``
- ``InvocationSupport``
- ``SizeEvaluation``
- ``ThinningReport``
- ``ThinningReportError``
- ``BundleSizeScanner``
- ``BundleSize``
- ``BundleScanError``

### Website association and App Clip Codes

- <doc:AssociatingYourWebsite>
- ``AppClipCodeURLCheck``
- ``AppClipCodeFinding``
- ``AssociationFile``
- ``AssociationFileError``
- ``AssociationFileValidator``
- ``AssociationFinding``
- ``AssociatedDomain``
- ``AssociatedDomainError``
- ``AppIdentifier``
- ``AppIdentifierError``

### Moving to the full app

- <doc:HandingOffToTheFullApp>
- ``HandoffStore``
- ``HandoffError``

### Location confirmation

- ``ExpectedLocation``
- ``ExpectedLocationError``
- ``LocationConfirmation``
