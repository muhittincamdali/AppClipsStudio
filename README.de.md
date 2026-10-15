<!-- i18n-source: README.md@3cf58e24b820b24a8295e661fa1b11e872eb9e84 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-de-light.svg" alt="AppClipsStudio: Aufruf-Routing, Größenprüfung und Website-Verknüpfung für iOS App Clips."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="CI-Status"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="Aktuelle Version: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="Unterstützte Plattformen: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="Sprachversion: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="Lizenz: MIT"></picture></a>
</p>

<p align="center">
<a href="#schnellstart"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-de-light.svg" alt="Loslegen"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-de-light.svg" alt="Dokumentation"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-de-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-de-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-de-light.svg" alt="Beispiele"></picture></a>
</p>

> Dies ist eine Übersetzung der englischen README. Bei Abweichungen gilt die englische Fassung.

<!-- brand:end -->

Ein Swift-Paket für iOS App Clips und die Apps, zu denen sie gehören. Es prüft die Aufruf-URL, die
das System beim Start übergibt, und leitet sie so an deine Screens weiter, wie App Store Connect sie
an App-Clip-Erlebnisse weiterleitet. Es bestätigt, dass die Person dort ist, wo der Code hängt, und
übergibt die Daten des App Clips an die vollständige App. Das Kommandozeilenwerkzeug
`appclipstudio` prüft vor dem Hochladen, was App Store Connect und das System prüfen werden: die
Größe jeder Variante, die URLs von App Clip Codes, die Datei `apple-app-site-association` und die
Einträge für Associated Domains. Das Paket hat keine Abhängigkeiten.

## Highlights

- **Aufruf-Routing nach Apples Abgleichsregel** — Muster wie `/table/:number` und `/shop/*`; es
  gewinnt das spezifischste Präfix, wie in App Store Connect, und ein Fallback deckt den Rest eines
  registrierten Präfixes ab, den laut Apple ein App Clip und seine vollständige App beide behandeln
  müssen. Standard-App-Clip-Links (`https://appclip.apple.com/id?p=…`) werden erkannt.
- **Nicht vertrauenswürdige Eingaben bleiben begrenzt** — Aufruf-URLs werden auf Schema, Host,
  Länge, Pfad- und Query-Größe sowie `.`/`..`-Komponenten geprüft, bevor dein Code sie sieht; Zahlen
  werden ohne Absturz geparst; Größenberichte weisen `nan`, `inf` und `1e999` zurück; Dateien
  werden mit einem Limit gelesen; der Ordner-Scan folgt keinen symbolischen Links; die Ausgabe gibt
  nie Steuerzeichen wieder.
- **Größenprüfung pro Variante** — Apples Grenzen von 10, 15 und 100 MB werden auf jede Variante
  aus Xcodes `App Thinning Size Report.txt` angewendet, getrennt nach iOS-Version, Deployment Target
  und Aufruftyp, mit einem Exit-Status für CI.
- **Website-Verknüpfung** — `apple-app-site-association` erzeugen und validieren,
  `appclips:`/`applinks:`-Entitlement-Einträge prüfen und App-Clip-Code-URLs gegen Apples
  Kodierungsregeln prüfen.
- **Der Moment nach der Aufgabe** — Standortbestätigung mit einer validierten Region von 500 m, das
  App-Store-Overlay für die vollständige App und `HandoffStore`, der einen versionierten, ablaufenden
  und in der Größe begrenzten Wert über die gemeinsame App Group an die vollständige App übergibt.
- **Getestet** — 114 Swift-Testing-Tests laufen auf macOS und in einem iPhone-Simulator, darunter
  die oben genannten Randfälle und der Schnellstart weiter unten.
- **Ein Beispiel, das sich bauen lässt** — [Examples/CoffeeShop](Examples/CoffeeShop) ist eine App
  mit ihrem App Clip aus denselben Quellen; CI baut es, und die Beispiele unter Verwendung sind
  daraus kopiert.

## Schnellstart

**1. Paket hinzufügen**

Wähle in Xcode **File › Add Package Dependencies…** und gib die Repository-URL ein:

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

Lass **Dependency Rule** bei **Up to Next Major Version** ab `2.0.0` und klicke auf **Add
Package**. Wähle im nächsten Fenster neben **AppClipsStudio** dein App-Clip-Target und klicke
erneut auf **Add Package**. (Hat dein Projekt noch keinen App Clip, füge einen über **File › New ›
Target… › App Clip** hinzu; füge das Paket auch dem Target der vollständigen App hinzu.)

**2. Aufruf routen**

Ersetze den gesamten Inhalt der `ContentView.swift` des App Clips durch:

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

**3. Mit einer Aufruf-URL ausführen**

Wähle **Product › Scheme › Edit Scheme…**, öffne **Run › Arguments** und setze die
Umgebungsvariable `_XCAppClipURL` (Xcode fügt sie jedem App-Clip-Scheme hinzu) auf
`https://appclip.example.com/table/12`. Wähle einen iPhone-Simulator und drücke **Run** (⌘R). Der
App Clip zeigt "Table 12"; mit `/table/twelve` oder ohne Pfad zeigt er "Scan a table tag".

Derselbe Code wird in
[`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift)
kompiliert und getestet.

## Installation

### Swift Package Manager

Füge die Bibliothek wie im Schnellstart in Xcode zu den Targets von App Clip und vollständiger App
hinzu, oder in der `Package.swift`:

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

### Kommandozeilenwerkzeug

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

Version 2.0.0 (Oktober 2026) ist die erste Veröffentlichung dieses Codes. Die frühere Version 1.0.0
(Februar 2026) beschrieb Module, die nie implementiert wurden; im Juni 2026 wurden sie auf Stubs
reduziert, und im Oktober 2026 wurde das Paket auf Grundlage von Apples App-Clip-Dokumentation neu
geschrieben. [CHANGELOG.md](CHANGELOG.md) listet die Änderungen auf.

## Verwendung

Die folgenden Beispiele sind aus der Beispiel-App
[`Examples/CoffeeShop`](Examples/CoffeeShop) kopiert, die CI baut.

### Routen

Aus [`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift): ein Tisch-Tag,
ein Plakatcode und der Standard-App-Clip-Link, mit dem Menü für jede andere URL.

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

Ein Handler, der `nil` zurückgibt (ein unbekanntes Geschäft, eine Tischnummer außerhalb des
Bereichs), lässt die nächste Route es versuchen und zuletzt den Fallback.

### Starts ohne URL

Aus [`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift). Wer aus einer
Benachrichtigung oder dem App-Umschalter zurückkehrt, startet den App Clip ohne URL; deshalb wird
jeder Aufruf gespeichert und wiederhergestellt:

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

### Standortbestätigung und App-Store-Overlay

Aus [`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift), nur für den App Clip (die
Compilation Condition `APPCLIP`):

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

Die `location` jedes Geschäfts ist eine `ExpectedLocation`, die nur endliche Koordinaten im
gültigen Bereich und einen Radius größer als 0 und höchstens 500 Meter akzeptiert, Apples Grenze.

### Die Bestellung an die vollständige App übergeben

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

`handoff` ist ein `HandoffStore<PlacedOrder>` auf der `UserDefaults`-Suite der App Group, die beide
Targets gemeinsam nutzen.

## Kommandozeilenwerkzeug

Prüfe jede Variante eines exportierten App Clips (der Exit-Status ist 1, wenn eine ihr Limit
überschreitet):

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

Prüfe URLs für App Clip Codes:

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

Erzeuge und validiere die Verknüpfungsdatei und prüfe Entitlement-Einträge:

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

Jeder Befehl akzeptiert `--json`. `appclipstudio help` listet die Optionen auf.

## Demo

Der Beispiel-App-Clip, geöffnet mit der URL eines Tisch-Tags und der URL eines Plakats:

| Tisch-Tag (hell)                                              | Tisch-Tag (dunkel)                                             | Plakat (hell)                                                   | Plakat (dunkel)                                                  |
| ------------------------------------------------------------------- | -------------------------------------------------------------------- | --------------------------------------------------------------- | ---------------------------------------------------------------- |
| ![Tisch 12 in der Harbor Street, hell](docs/images/table-light.png) | ![Tisch 12 in der Harbor Street, dunkel](docs/images/table-dark.png) | ![Plakatangebot Flat White, hell](docs/images/poster-light.png) | ![Plakatangebot Flat White, dunkel](docs/images/poster-dark.png) |

Die Screenshots entstehen in einem iPhone-Simulator mit
[`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh). Im Simulator übergibt das System
keine Aktivierungs-Payload, daher steht im Badge "Location not checked on this launch".

Zum Ausprobieren öffnest du `CoffeeShop.xcodeproj` in [`Examples/CoffeeShop`](Examples/CoffeeShop),
wählst das Scheme **CoffeeShopClip** und einen iPhone-Simulator und drückst **Run**.
[Examples/README.md](Examples/README.md) enthält die Details.

## Dokumentation

- [API-Referenz](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  (DocC, von `master` auf GitHub Pages veröffentlicht)
- Baue sie lokal in Xcode mit **Product › Build Documentation** oder über die Kommandozeile:

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## Anleitungen

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — das Paket beiden Targets hinzufügen, den Aufruf routen und testen
  ([Quelle](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md)).
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — was geprüft wird, die Mustersyntax und welche Route gewinnt
  ([Quelle](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md)).
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — Apples Grenzen, der Größenbericht und der Befehl `size`
  ([Quelle](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md)).
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — Entitlement-Einträge, `apple-app-site-association` und App-Clip-Code-URLs
  ([Quelle](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md)).
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — Standortbestätigung, App-Store-Overlay, Benachrichtigungen und `HandoffStore`
  ([Quelle](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md)).

## Voraussetzungen

| Plattform | Mindestversion                                                       |
| --------- | -------------------------------------------------------------------- |
| iOS       | 16 (Standortbestätigung und Overlay gibt es nur unter iOS)           |
| macOS     | 13 (das Kommandozeilenwerkzeug und die plattformneutralen Prüfungen) |
| Toolchain | Swift 6.2 · Xcode 26+                                                |

CI baut mit dem Standard-Xcode des `macos-26`-Runner-Images von GitHub. Das Paket wird mit Xcode 27
entwickelt. Die Beispiel-App hat iOS 17 als Ziel.

## Architektur

- `Sources/AppClipsStudio` ist die Bibliothek, ein Ordner pro Aufgabe: `Invocation`, `Routing`,
  `Size`, `AppClipCode`, `Association`, `Handoff`, `Location` und `Promotion`. Bis auf die
  SwiftUI-Modifier und die Erweiterung von `APActivationPayload` besteht alles aus Werttypen und
  reinen Funktionen und läuft und wird daher auch auf macOS getestet.
- Fehler sind typisiert (`throws(InvocationError)`, `throws(ThinningReportError)`, …), sodass
  Aufrufer jeden Fall per `switch` behandeln können.
- `Sources/AppClipsStudioTool` enthält die Befehle des Kommandozeilenwerkzeugs als Bibliothek, damit
  die Tests sie direkt aufrufen; `Sources/appclipstudio` reicht nur die Argumente weiter.
- CI führt `swift test` auf macOS und `xcodebuild test` in einem iPhone-Simulator aus, baut die
  Beispiel-App und veröffentlicht die DocC-Dokumentation.

Tests lokal ausführen:

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Roadmap

- Das Paket zum Swift Package Index hinzufügen; `.spi.yml` liegt bereits im Repository.
- Größen direkt aus einer exportierten `.ipa` lesen, ohne den Größenbericht.
- Eine Liste der App-Clip-Erlebnisse für die App Store Connect API (erweiterte Erlebnisse pro Standort).

## Mitwirken

Beiträge sind willkommen. Lies vor einem Pull Request den [Leitfaden für Beiträge](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md) und den [Verhaltenskodex](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md). Sicherheitsprobleme meldest du vertraulich, wie in der [Sicherheitsrichtlinie](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md) beschrieben.

## Lizenz

Veröffentlicht unter der MIT-Lizenz. Siehe [LICENSE](LICENSE).
