<!-- i18n-source: README.md@bc9667a3388772a73b5a72ffeaa8c3343928c884 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-es-light.svg" alt="AppClipsStudio: Enrutamiento de invocaciones, control de tamaño y asociación con tu web para App Clips de iOS."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="Estado de CI"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="Última versión: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="Plataformas compatibles: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="Versión del lenguaje: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="Licencia: MIT"></picture></a>
</p>

<p align="center">
<a href="#inicio-rápido"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-es-light.svg" alt="Empezar"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-es-light.svg" alt="Documentación"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-es-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-es-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-es-light.svg" alt="Ejemplos"></picture></a>
</p>

> Esta es una traducción del README en inglés. Si hay diferencias, la versión en inglés es la vigente.

<!-- brand:end -->

Un paquete de Swift para los App Clips de iOS y las apps a las que pertenecen. Valida la URL de
invocación que el sistema pasa al arrancar y la enruta a tus pantallas como App Store Connect la
enruta a las experiencias del App Clip, confirma que la persona está donde está el código y
entrega los datos del App Clip a la app completa. Su herramienta de línea de comandos
`appclipstudio` comprueba antes de subir lo que revisarán App Store Connect y el sistema: el
tamaño de cada variante, las URL de los App Clip Codes, el archivo `apple-app-site-association` y
las entradas de Associated Domains. El paquete no tiene dependencias.

## Lo más destacado

- **Enrutamiento de invocaciones con la regla de coincidencia de Apple** — patrones como
  `/table/:number` y `/shop/*`; gana el prefijo más específico, igual que en App Store Connect, y
  un fallback cubre el resto de un prefijo registrado, que Apple exige que gestionen tanto el App
  Clip como su app completa. Se reconocen los enlaces predeterminados de App Clip
  (`https://appclip.apple.com/id?p=…`).
- **La entrada no confiable queda acotada** — las URL de invocación se comprueban (esquema, host,
  longitud, tamaño de la ruta y de la consulta, y componentes `.`/`..`) antes de que tu código las
  vea; los números se interpretan sin provocar fallos; los informes de tamaño rechazan `nan`,
  `inf` y `1e999`; los archivos se leen con un límite; el análisis de carpetas no sigue enlaces
  simbólicos; la salida nunca reproduce caracteres de control.
- **Comprobación de tamaño por variante** — los límites de Apple de 10, 15 y 100 MB se aplican a
  cada variante del `App Thinning Size Report.txt` de Xcode según la versión de iOS, el destino de
  despliegue y el tipo de invocación, con un código de salida para CI.
- **Asociación con tu sitio web** — genera y valida `apple-app-site-association`, comprueba las
  entradas de entitlements `appclips:`/`applinks:` y revisa las URL de los App Clip Codes según
  las reglas de codificación de Apple.
- **El momento posterior a la tarea** — confirmación de ubicación con una región validada de
  500 m, el overlay de la App Store para la app completa y `HandoffStore`, que pasa a la app
  completa un valor con versión, caducidad y tamaño limitado a través del App Group compartido.
- **Probado** — 119 pruebas de Swift Testing se ejecutan en macOS y en un simulador de iPhone,
  incluidos los casos límite anteriores y el inicio rápido de más abajo.
- **Un ejemplo que compila** — [Examples/CoffeeShop](Examples/CoffeeShop) es una app y su App Clip
  a partir de las mismas fuentes; CI lo compila y los ejemplos de Uso se copian de él.

## Inicio rápido

**1. Añade el paquete**

En Xcode, elige **File › Add Package Dependencies…** e introduce la URL del repositorio:

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

Deja **Dependency Rule** en **Up to Next Major Version** desde `2.0.0` y haz clic en **Add
Package**. En la ventana siguiente, elige tu target del App Clip junto a **AppClipsStudio** y haz
clic de nuevo en **Add Package**. (Si tu proyecto todavía no tiene un App Clip, añade uno con
**File › New › Target… › App Clip**; añade el paquete también al target de la app completa.)

**2. Enruta la invocación**

Sustituye todo el contenido del `ContentView.swift` del App Clip por:

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

**3. Ejecútalo con una URL de invocación**

Elige **Product › Scheme › Edit Scheme…**, selecciona **Run › Arguments** y define la variable de
entorno `_XCAppClipURL` (Xcode la añade a todos los esquemas de App Clip) con el valor
`https://appclip.example.com/table/12`. Elige un simulador de iPhone y pulsa **Run** (⌘R). El App
Clip muestra "Table 12"; con `/table/twelve` o sin ruta muestra "Scan a table tag".

El mismo código se compila y se prueba en
[`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift).

## Instalación

### Swift Package Manager

Añade la biblioteca a los targets del App Clip y de la app completa en Xcode, como en el inicio
rápido, o en `Package.swift`:

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

### Herramienta de línea de comandos

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

La versión 2.0.0 (octubre de 2026) es la primera publicación de este código. La anterior, la 1.0.0
(febrero de 2026), describía módulos que nunca se implementaron; en junio de 2026 se redujeron a
stubs y en octubre de 2026 el paquete se reescribió a partir de la documentación de Apple sobre los
App Clips. [CHANGELOG.md](CHANGELOG.md) enumera lo que cambió.

## Uso

Los ejemplos siguientes están copiados de la app de ejemplo
[`Examples/CoffeeShop`](Examples/CoffeeShop), que CI compila.

### Rutas

De [`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift): una etiqueta de
mesa, un código de póster y el enlace predeterminado del App Clip, con el menú para cualquier otra
URL.

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

Un manejador que devuelve `nil` (una tienda desconocida, un número de mesa fuera de rango) deja que
lo intente la siguiente ruta y, por último, el fallback.

### Inicios sin URL

De [`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift). Quien vuelve desde
una notificación o desde el selector de apps abre el App Clip sin URL, así que cada invocación se
guarda y se restaura:

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

### Confirmación de ubicación y overlay de la App Store

De [`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift), solo para el App Clip (la
condición de compilación `APPCLIP`):

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

La `location` de cada tienda es una `ExpectedLocation`, que solo acepta coordenadas finitas dentro
del rango y un radio mayor que 0 y de como máximo 500 metros, el límite de Apple.

### Entregar el pedido a la app completa

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

`handoff` es un `HandoffStore<PlacedOrder>` sobre la suite de `UserDefaults` del App Group,
compartida por ambos targets.

## Herramienta de línea de comandos

Comprueba todas las variantes de un App Clip exportado (el código de salida es 1 cuando alguna
supera su límite):

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

Comprueba las URL de los App Clip Codes:

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

Genera y valida el archivo de asociación y comprueba las entradas de entitlements:

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

Todos los comandos aceptan `--json`. `appclipstudio help` muestra las opciones.

## Demo

El App Clip de ejemplo abierto con la URL de una etiqueta de mesa y con la URL de un póster:

| Etiqueta de mesa (claro)                                             | Etiqueta de mesa (oscuro)                                            | Póster (claro)                                                               | Póster (oscuro)                                                              |
| -------------------------------------------------------------------- | -------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| ![Mesa 12 en Harbor Street, modo claro](docs/images/table-light.png) | ![Mesa 12 en Harbor Street, modo oscuro](docs/images/table-dark.png) | ![Oferta del póster de Flat White, modo claro](docs/images/poster-light.png) | ![Oferta del póster de Flat White, modo oscuro](docs/images/poster-dark.png) |

Las capturas se hacen en un simulador de iPhone con
[`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh). En el simulador el sistema no
pasa ningún payload de activación, por lo que la insignia dice "Location not checked on this launch".

Para probarlo tú mismo, abre `CoffeeShop.xcodeproj` en [`Examples/CoffeeShop`](Examples/CoffeeShop),
elige el esquema **CoffeeShopClip** y un simulador de iPhone, y pulsa **Run**.
[Examples/README.md](Examples/README.md) tiene los detalles.

## Documentación

- [Referencia de la API](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  (DocC, publicada en GitHub Pages desde `master`)
- Compílala en local en Xcode con **Product › Build Documentation**, o desde la línea de comandos:

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## Guías

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — añade el paquete a ambos targets, enruta la invocación y pruébala
  ([fuente](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md)).
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — qué se comprueba, la sintaxis de los patrones y qué ruta gana
  ([fuente](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md)).
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — los límites de Apple, el informe de tamaño y el comando `size`
  ([fuente](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md)).
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — entradas de entitlements, `apple-app-site-association` y URL de App Clip Codes
  ([fuente](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md)).
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — confirmación de ubicación, overlay de la App Store, notificaciones y `HandoffStore`
  ([fuente](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md)).

## Requisitos

| Plataforma   | Versión mínima                                                                                |
| ------------ | --------------------------------------------------------------------------------------------- |
| iOS          | 16 (la confirmación de ubicación y el overlay son solo para iOS)                              |
| macOS        | 13 (la herramienta de línea de comandos y las comprobaciones independientes de la plataforma) |
| Herramientas | Swift 6.2 · Xcode 26+                                                                         |

CI compila con el Xcode predeterminado de la imagen de runner `macos-26` de GitHub. El paquete se
desarrolla con Xcode 27. La app de ejemplo apunta a iOS 17.

## Arquitectura

- `Sources/AppClipsStudio` es la biblioteca, con una carpeta por tarea: `Invocation`, `Routing`,
  `Size`, `AppClipCode`, `Association`, `Handoff`, `Location` y `Promotion`. Todo, salvo los
  modifiers de SwiftUI y la extensión de `APActivationPayload`, son tipos de valor y funciones
  puras, así que también se ejecuta y se prueba en macOS.
- Los errores están tipados (`throws(InvocationError)`, `throws(ThinningReportError)`, …) para que
  quien llama pueda hacer `switch` sobre todos los casos.
- `Sources/AppClipsStudioTool` contiene los comandos de la herramienta de línea de comandos como
  biblioteca, de modo que las pruebas los llaman directamente; `Sources/appclipstudio` solo
  reenvía los argumentos.
- CI ejecuta `swift test` en macOS y `xcodebuild test` en un simulador de iPhone, compila la app de
  ejemplo y publica la documentación de DocC.

Ejecuta las pruebas en local:

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Hoja de ruta

- Añadir el paquete al Swift Package Index; `.spi.yml` ya está en el repositorio.
- Leer los tamaños directamente de un `.ipa` exportado, sin el informe de tamaño.
- Una lista de experiencias de App Clip para la API de App Store Connect (experiencias avanzadas por ubicación).

## Contribuir

Las contribuciones son bienvenidas. Lee la [guía de contribución](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md) y el [código de conducta](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) antes de abrir una pull request. Informa de los problemas de seguridad de forma privada, como se describe en la [política de seguridad](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Licencia

Publicado bajo la licencia MIT. Consulta [LICENSE](LICENSE).
