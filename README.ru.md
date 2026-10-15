<!-- i18n-source: README.md@9ad05c687cb5524941c112f26431f3c6a71ac750 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ru-light.svg" alt="AppClipsStudio: Маршрутизация вызовов, проверка размера и связь с сайтом для App Clip в iOS."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="Статус CI"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="Последняя версия: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="Поддерживаемые платформы: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="Версия языка: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="Лицензия: MIT"></picture></a>
</p>

<p align="center">
<a href="#быстрый-старт"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ru-light.svg" alt="Начать"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ru-light.svg" alt="Документация"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ru-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ru-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ru-light.svg" alt="Примеры"></picture></a>
</p>

> Это перевод README на английском языке. Если они расходятся, актуальна английская версия.

<!-- brand:end -->

Swift-пакет для App Clip в iOS и приложений, к которым они относятся. Он проверяет URL вызова,
который система передаёт при запуске, и направляет его на ваши экраны так же, как App Store Connect
направляет его к возможностям App Clip, подтверждает, что человек находится там, где размещён код,
и передаёт данные App Clip полному приложению. Его инструмент командной строки `appclipstudio`
проверяет до загрузки то, что проверят App Store Connect и система: размер каждого варианта, URL
для App Clip Code, файл `apple-app-site-association` и записи Associated Domains. У пакета нет
зависимостей.

## Основные возможности

- **Маршрутизация вызовов по правилу сопоставления Apple** — шаблоны вроде `/table/:number` и
  `/shop/*`; побеждает самый конкретный префикс, как в App Store Connect, а fallback покрывает
  остальное в зарегистрированном префиксе, который, по требованию Apple, должны обрабатывать и App
  Clip, и полное приложение. Ссылки App Clip по умолчанию (`https://appclip.apple.com/id?p=…`)
  распознаются.
- **Недоверенный ввод остаётся ограниченным** — URL вызова проверяются на схему, хост, длину,
  размер пути и запроса, а также на компоненты `.`/`..` ещё до того, как их увидит ваш код; числа
  разбираются без аварийного завершения; отчёты о размере отклоняют `nan`, `inf` и `1e999`; файлы
  читаются с ограничением; при сканировании папок символические ссылки не разворачиваются; в
  вывод никогда не попадают управляющие символы.
- **Проверка размера по вариантам** — ограничения Apple в 10, 15 и 100 МБ применяются к каждому
  варианту из `App Thinning Size Report.txt` в Xcode с учётом версии iOS, минимальной версии
  развёртывания и типа вызова; для CI возвращается код завершения.
- **Связь с сайтом** — создание и проверка `apple-app-site-association`, проверка записей
  entitlements `appclips:`/`applinks:` и проверка URL для App Clip Code по правилам кодирования
  Apple.
- **Момент после выполнения задачи** — подтверждение местоположения с проверенной областью в 500 м,
  оверлей App Store для полного приложения и `HandoffStore`, который передаёт полному приложению
  версионированное значение с ограниченным сроком действия и размером через общий App Group.
- **Протестировано** — 114 тестов Swift Testing выполняются на macOS и в симуляторе iPhone, в том
  числе описанные выше граничные случаи и быстрый старт ниже.
- **Пример, который собирается** — [Examples/CoffeeShop](Examples/CoffeeShop) — приложение и его
  App Clip из одних и тех же исходников; CI собирает его, а примеры из раздела «Использование»
  скопированы оттуда.

## Быстрый старт

**1. Добавьте пакет**

В Xcode выберите **File › Add Package Dependencies…** и введите адрес репозитория:

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

Оставьте **Dependency Rule** в значении **Up to Next Major Version** начиная с `2.0.0` и нажмите
**Add Package**. В следующем окне выберите цель вашего App Clip рядом с **AppClipsStudio** и снова
нажмите **Add Package**. (Если в проекте ещё нет App Clip, добавьте его через **File › New ›
Target… › App Clip**; добавьте пакет также в цель полного приложения.)

**2. Направьте вызов**

Замените всё содержимое файла `ContentView.swift` в App Clip следующим кодом:

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

**3. Запустите с URL вызова**

Выберите **Product › Scheme › Edit Scheme…**, откройте **Run › Arguments** и задайте переменной
окружения `_XCAppClipURL` (Xcode добавляет её в каждую схему App Clip) значение
`https://appclip.example.com/table/12`. Выберите симулятор iPhone и нажмите **Run** (⌘R). App Clip
покажет "Table 12"; с `/table/twelve` или без пути он покажет "Scan a table tag".

Тот же код компилируется и тестируется в
[`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift).

## Установка

### Swift Package Manager

Добавьте библиотеку в цели App Clip и полного приложения в Xcode, как в быстром старте, или в
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

### Инструмент командной строки

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

Версия 2.0.0 (октябрь 2026 года) — первый релиз этого кода. Предыдущий релиз 1.0.0 (февраль 2026
года) описывал модули, которые так и не были реализованы; в июне 2026 года они были сведены к
заглушкам, а в октябре 2026 года пакет был переписан по документации Apple об App Clip. Что
изменилось, перечислено в [CHANGELOG.md](CHANGELOG.md).

## Использование

Приведённые ниже примеры скопированы из демонстрационного приложения
[`Examples/CoffeeShop`](Examples/CoffeeShop), которое собирает CI.

### Маршруты

Из [`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift): метка на столе,
код на плакате и ссылка App Clip по умолчанию, а для любого другого URL открывается меню.

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

Обработчик, вернувший `nil` (неизвестный магазин, номер стола вне допустимого диапазона), даёт
возможность следующему маршруту, а в конце — fallback.

### Запуски без URL

Из [`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift). Человек, который
возвращается из уведомления или из переключателя приложений, запускает App Clip без URL, поэтому
каждый вызов сохраняется и восстанавливается:

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

### Подтверждение местоположения и оверлей App Store

Из [`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift), только для App Clip
(условие компиляции `APPCLIP`):

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

`location` каждого магазина — это `ExpectedLocation`; он принимает только конечные координаты в
допустимом диапазоне и радиус больше 0 и не более 500 метров, то есть в пределах лимита Apple.

### Передача заказа полному приложению

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

`handoff` — это `HandoffStore<PlacedOrder>` на наборе `UserDefaults` App Group, общем для обеих
целей.

## Инструмент командной строки

Проверьте каждый вариант экспортированного App Clip (код завершения равен 1, если какой-либо
вариант превышает свой лимит):

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

Проверьте URL для App Clip Code:

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

Создайте и проверьте файл ассоциации, а также проверьте записи entitlements:

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

Каждая команда принимает `--json`. Список параметров выводит `appclipstudio help`.

## Демо

Демонстрационный App Clip, открытый по URL метки на столе и по URL плаката:

| Метка на столе (светлая тема)                                          | Метка на столе (тёмная тема)                                         | Плакат (светлая тема)                                                            | Плакат (тёмная тема)                                                           |
| ---------------------------------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ![Стол 12 на Harbor Street, светлая тема](docs/images/table-light.png) | ![Стол 12 на Harbor Street, тёмная тема](docs/images/table-dark.png) | ![Предложение Flat White на плакате, светлая тема](docs/images/poster-light.png) | ![Предложение Flat White на плакате, тёмная тема](docs/images/poster-dark.png) |

Скриншоты снимаются в симуляторе iPhone скриптом
[`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh). В симуляторе система не
передаёт payload активации, поэтому на значке написано "Location not checked on this launch".

Чтобы попробовать самостоятельно, откройте `CoffeeShop.xcodeproj` в
[`Examples/CoffeeShop`](Examples/CoffeeShop), выберите схему **CoffeeShopClip** и симулятор iPhone
и нажмите **Run**. Подробности — в [Examples/README.md](Examples/README.md).

## Документация

- [Справочник API](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  (DocC, публикуется на GitHub Pages из ветки `master`)
- Соберите его локально в Xcode через **Product › Build Documentation** или из командной строки:

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## Руководства

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — добавьте пакет в обе цели, направьте вызов и протестируйте его
  ([исходник](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md)).
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — что проверяется, синтаксис шаблонов и какой маршрут побеждает
  ([исходник](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md)).
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — ограничения Apple, отчёт о размере и команда `size`
  ([исходник](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md)).
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — записи entitlements, `apple-app-site-association` и URL для App Clip Code
  ([исходник](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md)).
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — подтверждение местоположения, оверлей App Store, уведомления и `HandoffStore`
  ([исходник](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md)).

## Требования

| Платформа   | Минимальная версия                                                     |
| ----------- | ---------------------------------------------------------------------- |
| iOS         | 16 (подтверждение местоположения и оверлей работают только в iOS)      |
| macOS       | 13 (инструмент командной строки и проверки, не зависящие от платформы) |
| Инструменты | Swift 6.2 · Xcode 26+                                                  |

CI собирает проект в Xcode по умолчанию из образа раннера `macos-26` на GitHub. Пакет
разрабатывается в Xcode 27. Демонстрационное приложение рассчитано на iOS 17.

## Архитектура

- `Sources/AppClipsStudio` — это библиотека, по одной папке на задачу: `Invocation`, `Routing`,
  `Size`, `AppClipCode`, `Association`, `Handoff`, `Location` и `Promotion`. Всё, кроме
  модификаторов SwiftUI и расширения `APActivationPayload`, состоит из типов-значений и чистых
  функций, поэтому запускается и тестируется и на macOS.
- Ошибки типизированы (`throws(InvocationError)`, `throws(ThinningReportError)`, …), чтобы
  вызывающий код мог разобрать через `switch` каждый случай.
- `Sources/AppClipsStudioTool` содержит команды инструмента командной строки в виде библиотеки,
  поэтому тесты вызывают их напрямую; `Sources/appclipstudio` лишь передаёт аргументы.
- CI запускает `swift test` на macOS и `xcodebuild test` в симуляторе iPhone, собирает
  демонстрационное приложение и публикует документацию DocC.

Запустите тесты локально:

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## План развития

- Добавить пакет в Swift Package Index; `.spi.yml` уже есть в репозитории.
- Читать размеры прямо из экспортированного `.ipa`, без отчёта о размере.
- Список возможностей App Clip для App Store Connect API (расширенные возможности для отдельных мест).

## Участие в разработке

Мы рады вашему участию. Перед открытием pull request прочитайте [руководство для участников](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md) и [кодекс поведения](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md). О проблемах безопасности сообщайте конфиденциально, как описано в [политике безопасности](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## Лицензия

Распространяется по лицензии MIT. Подробнее — в файле [LICENSE](LICENSE).
