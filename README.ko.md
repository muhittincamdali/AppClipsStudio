<!-- i18n-source: README.md@3cf58e24b820b24a8295e661fa1b11e872eb9e84 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ko-light.svg" alt="AppClipsStudio: iOS App Clip을 위한 호출 라우팅, 크기 검사, 웹사이트 연결."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="CI 상태"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="최신 버전: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="지원 플랫폼: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="언어 버전: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="라이선스: MIT"></picture></a>
</p>

<p align="center">
<a href="#빠른-시작"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ko-light.svg" alt="시작하기"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ko-light.svg" alt="문서"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ko-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ko-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ko-light.svg" alt="예제"></picture></a>
</p>

> 이 문서는 영어 README의 번역본입니다. 내용이 다를 경우 영어 버전이 최신입니다.

<!-- brand:end -->

iOS App Clip과 그것이 속한 앱을 위한 Swift 패키지입니다. 시스템이 실행 시 전달하는 호출 URL을 검증하고, App Store Connect가 App Clip 경험으로 연결하는 방식 그대로 앱 화면으로 라우팅합니다. 또한 사용자가 코드가 있는 곳에 실제로 있는지 확인하고, App Clip의 데이터를 전체 앱으로 넘겨 줍니다. 함께 제공되는 `appclipstudio` 명령줄 도구는 업로드하기 전에 App Store Connect와 시스템이 확인할 항목을 미리 점검합니다. 각 변형(variant)의 크기, App Clip Code URL, `apple-app-site-association` 파일, Associated Domains 항목이 대상입니다. 이 패키지에는 의존성이 없습니다.

## 주요 기능

- **Apple의 매칭 규칙을 따르는 호출 라우팅** — `/table/:number`, `/shop/*` 같은 패턴을 지원합니다. App Store Connect와 마찬가지로 가장 구체적인 접두사가 우선하며, 등록된 접두사의 나머지 경로는 fallback이 처리합니다. Apple은 App Clip과 전체 앱 모두 이를 처리하도록 요구합니다. 기본 App Clip 링크 (`https://appclip.apple.com/id?p=…`)도 인식합니다.
- **신뢰할 수 없는 입력을 제한** — 호출 URL은 코드에 전달되기 전에 스킴, 호스트, 길이, 경로와 쿼리의 크기, `.`/`..` 요소를 검사합니다. 숫자는 충돌 없이 파싱하고, 크기 보고서는 `nan`, `inf`, `1e999`를 거부하며, 파일은 크기 제한을 두고 읽고, 폴더 스캔은 심볼릭 링크를 따라가지 않으며, 출력에는 제어 문자를 그대로 내보내지 않습니다.
- **변형별 크기 검사** — Apple의 10MB, 15MB, 100MB 제한을 Xcode의 `App Thinning Size Report.txt`에 있는 각 변형에 iOS 버전, 배포 대상, 호출 유형별로 적용하고, CI에서 쓸 수 있는 종료 상태를 반환합니다.
- **웹사이트 연결** — `apple-app-site-association`을 생성하고 검증하며, `appclips:`/`applinks:` entitlement 항목을 확인하고, Apple의 인코딩 규칙에 따라 App Clip Code URL을 점검합니다.
- **작업이 끝난 직후의 순간** — 검증된 500m 영역으로 위치를 확인하고, 전체 앱을 위한 App Store 오버레이를 보여 주며, 공유 App Group을 통해 버전이 있고 만료되며 크기가 제한된 값을 전체 앱에 전달하는 `HandoffStore`를 제공합니다.
- **테스트 완료** — 114개의 Swift Testing 테스트를 macOS와 iPhone 시뮬레이터에서 실행하며, 위의 엣지 케이스와 아래의 빠른 시작도 포함합니다.
- **빌드되는 예제** — [Examples/CoffeeShop](Examples/CoffeeShop)은 같은 소스로 만든 앱과 그 App Clip입니다. CI에서 빌드하며, 사용법의 예제 코드도 여기에서 가져왔습니다.

## 빠른 시작

**1. 패키지 추가**

Xcode에서 **File › Add Package Dependencies…**를 선택하고 저장소 URL을 입력하세요.

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

**Dependency Rule**은 `2.0.0`부터의 **Up to Next Major Version**으로 두고 **Add Package**를 클릭하세요. 다음 창에서 **AppClipsStudio** 옆에 App Clip 타깃을 선택하고 **Add Package**를 다시 클릭합니다. (프로젝트에 아직 App Clip이 없다면 **File › New › Target… › App Clip**으로 추가하세요. 전체 앱 타깃에도 패키지를 추가해야 합니다.)

**2. 호출 라우팅**

App Clip의 `ContentView.swift` 내용을 모두 다음 코드로 바꾸세요.

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

**3. 호출 URL로 실행**

**Product › Scheme › Edit Scheme…**을 선택하고 **Run › Arguments**에서 환경 변수 `_XCAppClipURL` (Xcode가 모든 App Clip 스킴에 추가합니다)을 다음 값으로 설정하세요:
`https://appclip.example.com/table/12`.
iPhone 시뮬레이터를 선택하고 **Run** (⌘R)을 누르면 App Clip이 "Table 12"를 표시합니다. `/table/twelve`이거나 경로가 없으면 "Scan a table tag"를 표시합니다.

같은 코드를 [`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift)에서 컴파일하고 테스트합니다.

## 설치

### Swift Package Manager

빠른 시작처럼 Xcode에서 App Clip과 전체 앱 타깃에 라이브러리를 추가하거나, `Package.swift`에 다음과 같이 추가하세요.

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

### 명령줄 도구

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

2.0.0 버전 (2026년 10월)은 이 코드의 첫 번째 릴리스입니다. 이전 릴리스인 1.0.0 (2026년 2월)은 구현된 적 없는 모듈을 설명했고, 2026년 6월에 그 모듈들이 스텁으로 축소되었으며, 2026년 10월에 Apple의 App Clip 문서를 바탕으로 패키지를 다시 작성했습니다. 달라진 내용은 [CHANGELOG.md](CHANGELOG.md)에 정리되어 있습니다.

## 사용법

아래 예제는 CI에서 빌드하는 예제 앱 [`Examples/CoffeeShop`](Examples/CoffeeShop)에서 가져왔습니다.

### 라우트

[`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift)에서 가져왔습니다. 테이블 태그, 포스터 코드, 기본 App Clip 링크를 처리하고, 그 밖의 모든 URL은 메뉴를 보여 줍니다.

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

핸들러가 `nil`을 반환하면 (알 수 없는 매장, 범위를 벗어난 테이블 번호) 다음 라우트가 시도되고, 마지막으로 fallback이 실행됩니다.

### URL 없이 실행되는 경우

[`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift)에서 가져왔습니다. 알림이나 App Switcher에서 돌아온 사용자는 URL 없이 App Clip을 실행하므로, 호출할 때마다 저장하고 복원합니다.

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

### 위치 확인과 App Store 오버레이

[`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift)에서 가져왔으며, App Clip 전용입니다 (`APPCLIP` 컴파일 조건).

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

각 매장의 `location`은 `ExpectedLocation`이며, 범위 안의 유한한 좌표와 0보다 크고 500미터 이하인 반경(Apple의 제한)만 받습니다.

### 주문을 전체 앱에 넘기기

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

`handoff`는 App Group의 `UserDefaults` suite 위에서 동작하는 `HandoffStore<PlacedOrder>`이며, 두 타깃이 함께 사용합니다.

## 명령줄 도구

내보낸 App Clip의 모든 변형을 검사합니다 (제한을 넘는 변형이 있으면 종료 상태가 1입니다).

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

App Clip Code용 URL을 검사합니다.

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

연결 파일을 생성하고 검증하며, entitlement 항목을 확인합니다.

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

모든 명령은 `--json` 옵션을 받습니다. `appclipstudio help`로 옵션 목록을 볼 수 있습니다.

## 데모

예제 App Clip을 테이블 태그 URL과 포스터 URL로 연 모습입니다.

| 테이블 태그 (라이트)                                                | 테이블 태그 (다크)                                               | 포스터 (라이트)                                                 | 포스터 (다크)                                                |
| ------------------------------------------------------------------- | ---------------------------------------------------------------- | --------------------------------------------------------------- | ------------------------------------------------------------ |
| ![Harbor Street의 12번 테이블, 라이트](docs/images/table-light.png) | ![Harbor Street의 12번 테이블, 다크](docs/images/table-dark.png) | ![Flat White 포스터 혜택, 라이트](docs/images/poster-light.png) | ![Flat White 포스터 혜택, 다크](docs/images/poster-dark.png) |

스크린샷은 [`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh)로 iPhone 시뮬레이터에서 캡처했습니다. 시뮬레이터에서는 시스템이 활성화 페이로드를 전달하지 않으므로 배지에 "Location not checked on this launch"가 표시됩니다.

직접 해 보려면 [`Examples/CoffeeShop`](Examples/CoffeeShop)의 `CoffeeShop.xcodeproj`를 열고 **CoffeeShopClip** 스킴과 iPhone 시뮬레이터를 선택한 뒤 **Run**을 누르세요. 자세한 내용은 [Examples/README.md](Examples/README.md)를 참고하세요.

## 문서

- [API 레퍼런스](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  (DocC, `master`에서 GitHub Pages로 게시)
- Xcode의 **Product › Build Documentation**으로 로컬에서 빌드하거나, 명령줄에서 실행하세요.

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## 가이드

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — 두 타깃에 패키지를 추가하고, 호출을 라우팅하고, 테스트하기
  ([소스](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md)).
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — 무엇을 검사하는지, 패턴 문법, 어떤 라우트가 우선하는지
  ([소스](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md)).
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — Apple의 제한, 크기 보고서, `size` 명령
  ([소스](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md)).
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — entitlement 항목, `apple-app-site-association`, App Clip Code URL
  ([소스](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md)).
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — 위치 확인, App Store 오버레이, 알림, `HandoffStore`
  ([소스](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md)).

## 요구 사항

| 플랫폼 | 최소 버전                                      |
| ------ | ---------------------------------------------- |
| iOS    | 16 (위치 확인과 오버레이는 iOS 전용)           |
| macOS  | 13 (명령줄 도구와 플랫폼에 의존하지 않는 검사) |
| 툴체인 | Swift 6.2 · Xcode 26+                          |

CI는 GitHub `macos-26` 러너 이미지의 기본 Xcode로 빌드합니다. 이 패키지는 Xcode 27로 개발합니다. 예제 앱의 대상은 iOS 17입니다.

## 아키텍처

- `Sources/AppClipsStudio`가 라이브러리이며, 작업마다 폴더가 하나씩 있습니다. `Invocation`, `Routing`, `Size`, `AppClipCode`, `Association`, `Handoff`, `Location`, `Promotion`입니다. SwiftUI modifier와 `APActivationPayload` 확장을 제외하면 모두 값 타입과 순수 함수라서 macOS에서도 실행하고 테스트할 수 있습니다.
- 오류는 타입이 지정되어 있어 (`throws(InvocationError)`, `throws(ThinningReportError)` 등) 호출하는 쪽에서 모든 경우를 `switch`로 처리할 수 있습니다.
- `Sources/AppClipsStudioTool`에는 명령줄 도구의 명령이 라이브러리로 들어 있어 테스트가 직접 호출합니다. `Sources/appclipstudio`는 인자만 전달합니다.
- CI는 macOS에서 `swift test`를, iPhone 시뮬레이터에서 `xcodebuild test`를 실행하고, 예제 앱을 빌드하며, DocC 문서를 게시합니다.

로컬에서 테스트를 실행하려면 다음과 같이 하세요.

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## 로드맵

- 패키지를 Swift Package Index에 추가하기. `.spi.yml`은 이미 저장소에 있습니다.
- 크기 보고서 없이 내보낸 `.ipa`에서 직접 크기 읽기.
- App Store Connect API용 App Clip 경험 목록 (위치별 고급 경험).

## 기여하기

기여를 환영합니다. pull request를 열기 전에 [기여 가이드](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md)와 [행동 강령](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md)을 읽어 주세요. 보안 문제는 [보안 정책](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md)에 따라 비공개로 제보해 주세요.

## 라이선스

MIT 라이선스로 배포됩니다. 자세한 내용은 [LICENSE](LICENSE)를 참고하세요.
