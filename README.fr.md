<!-- i18n-source: README.md@bc9667a3388772a73b5a72ffeaa8c3343928c884 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-fr-light.svg" alt="AppClipsStudio: Routage des invocations, contrôle de taille et association au site web pour les App Clips iOS."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="État de la CI"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="Dernière version: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="Plateformes prises en charge: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="Version du langage: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="Licence: MIT"></picture></a>
</p>

<p align="center">
<a href="#démarrage-rapide"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-fr-light.svg" alt="Commencer"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-fr-light.svg" alt="Documentation"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-fr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-fr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-fr-light.svg" alt="Exemples"></picture></a>
</p>

> Ceci est une traduction du README anglais. En cas de différence, la version anglaise fait foi.

<!-- brand:end -->

Un paquet Swift pour les App Clips iOS et les apps auxquelles ils appartiennent. Il valide l’URL
d’invocation que le système transmet au lancement et l’achemine vers vos écrans comme App Store
Connect l’achemine vers les expériences de l’App Clip, vérifie que la personne se trouve bien là où
est le code et transmet les données de l’App Clip à l’app complète. Son outil en ligne de commande
`appclipstudio` vérifie, avant l’envoi, ce que contrôleront App Store Connect et le système : la
taille de chaque variante, les URL des App Clip Codes, le fichier `apple-app-site-association` et
les entrées Associated Domains. Le paquet n’a aucune dépendance.

## Points forts

- **Routage des invocations selon la règle de correspondance d’Apple** — des motifs comme
  `/table/:number` et `/shop/*` ; le préfixe le plus spécifique l’emporte, comme dans App Store
  Connect, et une route de repli (fallback) couvre le reste d’un préfixe enregistré, que selon Apple
  l’App Clip et son app complète doivent tous deux gérer. Les liens App Clip par défaut
  (`https://appclip.apple.com/id?p=…`) sont reconnus.
- **Les entrées non fiables restent bornées** — les URL d’invocation sont vérifiées (schéma, hôte,
  longueur, taille du chemin et de la requête, composants `.`/`..`) avant que votre code ne les
  voie ; les nombres sont analysés sans provoquer de plantage ; les rapports de taille rejettent
  `nan`, `inf` et `1e999` ; les fichiers sont lus avec une limite ; l’analyse des dossiers ne suit
  pas les liens symboliques ; la sortie ne reproduit jamais de caractères de contrôle.
- **Contrôle de taille par variante** — les limites d’Apple de 10, 15 et 100 Mo sont appliquées à
  chaque variante du fichier `App Thinning Size Report.txt` de Xcode selon la version d’iOS, la
  cible de déploiement et le type d’invocation, avec un code de sortie pour la CI.
- **Association au site web** — générez et validez `apple-app-site-association`, vérifiez les
  entrées d’entitlements `appclips:`/`applinks:` et contrôlez les URL des App Clip Codes selon les
  règles d’encodage d’Apple.
- **Le moment qui suit la tâche** — confirmation de la position avec une région validée de 500 m,
  overlay de l’App Store pour l’app complète et `HandoffStore`, qui transmet à l’app complète une
  valeur versionnée, à durée de vie limitée et de taille bornée, via l’App Group partagé.
- **Testé** — 119 tests Swift Testing s’exécutent sur macOS et dans un simulateur d’iPhone, y
  compris les cas limites ci-dessus et le démarrage rapide ci-dessous.
- **Un exemple qui compile** — [Examples/CoffeeShop](Examples/CoffeeShop) est une app et son App
  Clip construits à partir des mêmes sources ; la CI le compile, et les exemples de la section
  Utilisation en sont copiés.

## Démarrage rapide

**1. Ajouter le paquet**

Dans Xcode, choisissez **File › Add Package Dependencies…** et saisissez l’URL du dépôt :

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

Laissez **Dependency Rule** sur **Up to Next Major Version** à partir de `2.0.0` et cliquez sur
**Add Package**. Dans la fenêtre suivante, choisissez votre cible App Clip à côté de
**AppClipsStudio** et cliquez de nouveau sur **Add Package**. (Si votre projet n’a pas encore
d’App Clip, ajoutez-en un avec **File › New › Target… › App Clip** ; ajoutez aussi le paquet à la
cible de l’app complète.)

**2. Router l’invocation**

Remplacez tout le contenu du fichier `ContentView.swift` de l’App Clip par :

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

**3. Lancer avec une URL d’invocation**

Choisissez **Product › Scheme › Edit Scheme…**, sélectionnez **Run › Arguments** et définissez la
variable d’environnement `_XCAppClipURL` (Xcode l’ajoute à chaque scheme d’App Clip) sur
`https://appclip.example.com/table/12`. Choisissez un simulateur d’iPhone et appuyez sur **Run**
(⌘R). L’App Clip affiche "Table 12" ; avec `/table/twelve` ou sans chemin, il affiche "Scan a table
tag".

Le même code est compilé et testé dans
[`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift).

## Installation

### Swift Package Manager

Ajoutez la bibliothèque aux cibles de l’App Clip et de l’app complète dans Xcode, comme dans le
démarrage rapide, ou dans `Package.swift` :

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

### Outil en ligne de commande

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

La version 2.0.0 (octobre 2026) est la première publication de ce code. La précédente, la 1.0.0
(février 2026), décrivait des modules qui n’ont jamais été implémentés ; en juin 2026 ils ont été
réduits à des stubs, et en octobre 2026 le paquet a été réécrit à partir de la documentation
d’Apple sur les App Clips. [CHANGELOG.md](CHANGELOG.md) liste ce qui a changé.

## Utilisation

Les exemples ci-dessous sont copiés de l’app d’exemple
[`Examples/CoffeeShop`](Examples/CoffeeShop), que la CI compile.

### Routes

Extrait de [`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift) : un tag de
table, un code d’affiche et le lien App Clip par défaut, avec le menu pour toute autre URL.

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

Un gestionnaire qui renvoie `nil` (un magasin inconnu, un numéro de table hors plage) laisse la
route suivante essayer, puis, en dernier, la route de repli.

### Lancements sans URL

Extrait de [`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift). Une personne
qui revient d’une notification ou du sélecteur d’apps lance l’App Clip sans URL ; chaque invocation
est donc enregistrée puis restaurée :

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

### Confirmation de la position et overlay de l’App Store

Extrait de [`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift), pour l’App Clip
uniquement (la condition de compilation `APPCLIP`) :

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

La `location` de chaque magasin est une `ExpectedLocation`, qui n’accepte que des coordonnées
finies dans la plage valide et un rayon supérieur à 0 et d’au plus 500 mètres, la limite d’Apple.

### Transmettre la commande à l’app complète

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

`handoff` est un `HandoffStore<PlacedOrder>` sur la suite `UserDefaults` de l’App Group, partagée
par les deux cibles.

## Outil en ligne de commande

Vérifiez chaque variante d’un App Clip exporté (le code de sortie est 1 lorsqu’une variante dépasse
sa limite) :

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

Vérifiez les URL des App Clip Codes :

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

Générez et validez le fichier d’association, puis vérifiez les entrées d’entitlements :

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

Chaque commande accepte `--json`. `appclipstudio help` liste les options.

## Démo

L’App Clip d’exemple ouvert avec l’URL d’un tag de table et celle d’une affiche :

| Tag de table (clair)                                                 | Tag de table (sombre)                                                | Affiche (clair)                                                            | Affiche (sombre)                                                           |
| -------------------------------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| ![Table 12 à Harbor Street, mode clair](docs/images/table-light.png) | ![Table 12 à Harbor Street, mode sombre](docs/images/table-dark.png) | ![Offre de l’affiche Flat White, mode clair](docs/images/poster-light.png) | ![Offre de l’affiche Flat White, mode sombre](docs/images/poster-dark.png) |

Les captures d’écran sont réalisées dans un simulateur d’iPhone par
[`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh). Dans le simulateur, le système
ne transmet aucun payload d’activation ; le badge affiche donc "Location not checked on this launch".

Pour l’essayer vous-même, ouvrez `CoffeeShop.xcodeproj` dans [`Examples/CoffeeShop`](Examples/CoffeeShop),
choisissez le scheme **CoffeeShopClip** et un simulateur d’iPhone, puis appuyez sur **Run**.
[Examples/README.md](Examples/README.md) donne les détails.

## Documentation

- [Référence de l’API](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  (DocC, publiée sur GitHub Pages depuis `master`)
- Compilez-la en local dans Xcode avec **Product › Build Documentation**, ou en ligne de commande :

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## Guides

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — ajouter le paquet aux deux cibles, router l’invocation et la tester
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md)).
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — ce qui est vérifié, la syntaxe des motifs et quelle route l’emporte
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md)).
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — les limites d’Apple, le rapport de taille et la commande `size`
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md)).
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — entrées d’entitlements, `apple-app-site-association` et URL des App Clip Codes
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md)).
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — confirmation de la position, overlay de l’App Store, notifications et `HandoffStore`
  ([source](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md)).

## Prérequis

| Plateforme      | Version minimale                                                                      |
| --------------- | ------------------------------------------------------------------------------------- |
| iOS             | 16 (la confirmation de la position et l’overlay existent uniquement sur iOS)          |
| macOS           | 13 (l’outil en ligne de commande et les vérifications indépendantes de la plateforme) |
| Chaîne d’outils | Swift 6.2 · Xcode 26+                                                                 |

La CI compile avec le Xcode par défaut de l’image de runner `macos-26` de GitHub. Le paquet est
développé avec Xcode 27. L’app d’exemple cible iOS 17.

## Architecture

- `Sources/AppClipsStudio` est la bibliothèque, avec un dossier par tâche : `Invocation`,
  `Routing`, `Size`, `AppClipCode`, `Association`, `Handoff`, `Location` et `Promotion`. Tout, à
  l’exception des modifiers SwiftUI et de l’extension de `APActivationPayload`, se compose de types
  valeur et de fonctions pures ; cela s’exécute et se teste donc aussi sur macOS.
- Les erreurs sont typées (`throws(InvocationError)`, `throws(ThinningReportError)`, …) afin que
  l’appelant puisse faire un `switch` sur chaque cas.
- `Sources/AppClipsStudioTool` contient les commandes de l’outil en ligne de commande sous forme de
  bibliothèque, pour que les tests les appellent directement ; `Sources/appclipstudio` se contente
  de transmettre les arguments.
- La CI exécute `swift test` sur macOS et `xcodebuild test` dans un simulateur d’iPhone, compile
  l’app d’exemple et publie la documentation DocC.

Exécutez les tests en local :

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Feuille de route

- Ajouter le paquet au Swift Package Index ; `.spi.yml` est déjà dans le dépôt.
- Lire les tailles directement depuis un `.ipa` exporté, sans le rapport de taille.
- Une liste des expériences App Clip pour l’API App Store Connect (expériences avancées par lieu).

## Contribuer

Les contributions sont les bienvenues. Lisez le [guide de contribution](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md) et le [code de conduite](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) avant d’ouvrir une pull request. Signalez les problèmes de sécurité en privé, comme indiqué dans la [politique de sécurité](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Licence

Publié sous licence MIT. Voir [LICENSE](LICENSE).
