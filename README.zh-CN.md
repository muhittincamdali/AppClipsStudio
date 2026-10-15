<!-- i18n-source: README.md@3cf58e24b820b24a8295e661fa1b11e872eb9e84 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-zh-CN-light.svg" alt="AppClipsStudio: 适用于 iOS App Clip 的调用路由、大小检查和网站关联。"></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="CI 状态"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="最新版本: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="支持的平台: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="语言版本: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="许可证: MIT"></picture></a>
</p>

<p align="center">
<a href="#快速开始"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-zh-CN-light.svg" alt="开始使用"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-zh-CN-light.svg" alt="文档"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-zh-CN-light.svg" alt="示例"></picture></a>
</p>

> 本文是英文 README 的译文。如两者内容不一致，以英文版为准。

<!-- brand:end -->

这是一个面向 iOS App Clip 及其所属 App 的 Swift 软件包。它会校验系统在启动时传入的调用 URL，并按照 App Store
Connect 将其路由到 App Clip 体验的方式，把它路由到你的界面；确认用户确实身处扫码位置；并把 App Clip
的数据交给完整 App。它自带的命令行工具 `appclipstudio` 会在你上传之前检查 App Store Connect 和系统将要检查的内容：每个变体的大小、App
Clip Code 的 URL、`apple-app-site-association` 文件以及 Associated Domains 条目。该软件包没有任何依赖。

## 亮点

- **按 Apple 的匹配规则进行调用路由** — 支持 `/table/:number` 和 `/shop/*` 这样的模式；与 App Store
  Connect 一样，最具体的前缀优先；兜底路由负责处理已注册前缀下的其余路径，而 Apple 要求 App Clip 及其完整 App
  都要处理这些路径。默认的 App Clip 链接 (`https://appclip.apple.com/id?p=…`) 也能识别。
- **不可信输入始终受限** — 在你的代码拿到调用 URL 之前，会先检查其协议、主机、长度、路径和查询字符串大小，以及 `.`/`..`
  路径组件；数字解析不会触发崩溃；大小报告会拒绝 `nan`、`inf` 和 `1e999`；读取文件有大小上限；文件夹扫描不会跟随符号链接；输出绝不会原样回显控制字符。
- **按变体检查大小** — 把 Apple 规定的 10 MB、15 MB 和 100 MB 上限，按 iOS 版本、部署目标和调用类型，逐个应用到 Xcode 的
  `App Thinning Size Report.txt` 中的每个变体，并返回可供 CI 使用的退出状态。
- **网站关联** — 生成并校验 `apple-app-site-association`，检查 `appclips:`/`applinks:` entitlement
  条目，并按 Apple 的编码规则检查 App Clip Code 的 URL。
- **任务完成之后的那一刻** — 带有已校验的 500 米范围的位置确认、用于完整 App 的 App Store 覆盖层，以及
  `HandoffStore`：它通过共享的 App Group，把带版本号、会过期、有大小限制的值交给完整 App。
- **经过测试** — 114 个 Swift Testing 测试在 macOS 和 iPhone 模拟器上运行，其中包括上述边界情况和下面的快速开始。
- **可以构建的示例** — [Examples/CoffeeShop](Examples/CoffeeShop) 用同一份源码构建出一个 App 及其 App
  Clip；CI 会构建它，“使用方法”中的示例代码也都是从中复制的。

## 快速开始

**1. 添加软件包**

在 Xcode 中选择 **File › Add Package Dependencies…**，然后输入仓库地址：

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

将 **Dependency Rule** 保持为从 `2.0.0` 起的 **Up to Next Major Version**，然后点击 **Add
Package**。在接下来的窗口中，在 **AppClipsStudio** 旁选择你的 App Clip target，再次点击 **Add
Package**。（如果项目里还没有 App Clip，请通过 **File › New › Target… › App Clip**
添加；也要把该软件包添加到完整 App 的 target。）

**2. 路由调用**

把 App Clip 的 `ContentView.swift` 中的全部内容替换为：

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

**3. 用调用 URL 运行**

选择 **Product › Scheme › Edit Scheme…**，打开 **Run › Arguments**，把环境变量 `_XCAppClipURL`（Xcode
会把它加到每个 App Clip scheme 中）设置为：
`https://appclip.example.com/table/12`.
选择一台 iPhone 模拟器并点击 **Run**（⌘R）。App Clip 会显示 "Table 12"；如果使用 `/table/twelve` 或不带路径，则显示 "Scan a table
tag"。

同样的代码在
[`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift)
中编译并测试。

## 安装

### Swift Package Manager

像快速开始中那样在 Xcode 中把该库添加到 App Clip 和完整 App 的 target，或者在 `Package.swift` 中添加：

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

### 命令行工具

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

2.0.0 版本（2026 年 10 月）是这份代码的首个正式版本。此前的 1.0.0 版本（2026 年 2 月）描述的模块从未真正实现；2026 年 6
月它们被精简为空壳，2026 年 10 月整个软件包依据 Apple 的 App Clip 文档重写。具体变更见 [CHANGELOG.md](CHANGELOG.md)。

## 使用方法

下面的示例复制自示例 App [`Examples/CoffeeShop`](Examples/CoffeeShop)，CI 会构建这个 App。

### 路由

来自 [`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift)：桌牌、海报码和默认的
App Clip 链接，其余所有 URL 都进入菜单。

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

如果处理闭包返回 `nil`（例如店铺未知、桌号超出范围），就会交给下一条路由尝试，最后才是兜底路由。

### 不带 URL 的启动

来自 [`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift)。用户从通知或 App
切换器返回时，App Clip 是在没有 URL 的情况下启动的，所以每次调用都会被保存并在之后恢复：

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

### 位置确认与 App Store 覆盖层

来自 [`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift)，仅限 App Clip（编译条件
`APPCLIP`）：

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

每家店铺的 `location` 都是一个 `ExpectedLocation`，它只接受范围内的有限坐标，以及大于 0 且不超过 500 米（Apple 的上限）的半径。

### 把订单交给完整 App

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

`handoff` 是建立在 App Group 的 `UserDefaults` suite 之上的 `HandoffStore<PlacedOrder>`，由两个 target 共享。

## 命令行工具

检查导出的 App Clip 的每个变体（有变体超出上限时，退出状态为 1）：

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

检查 App Clip Code 的 URL：

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

生成并校验关联文件，并检查 entitlement 条目：

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

每个命令都支持 `--json`。`appclipstudio help` 会列出所有选项。

## 演示

示例 App Clip 分别用桌牌 URL 和海报 URL 打开的效果：

| 桌牌（浅色）                                                   | 桌牌（深色）                                                  | 海报（浅色）                                               | 海报（深色）                                              |
| -------------------------------------------------------------- | ------------------------------------------------------------- | ---------------------------------------------------------- | --------------------------------------------------------- |
| ![Harbor Street 的 12 号桌，浅色](docs/images/table-light.png) | ![Harbor Street 的 12 号桌，深色](docs/images/table-dark.png) | ![Flat White 海报优惠，浅色](docs/images/poster-light.png) | ![Flat White 海报优惠，深色](docs/images/poster-dark.png) |

截图由 [`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh) 在 iPhone 模拟器上截取。在模拟器中，系统不会传入激活
payload，所以徽标显示 "Location not checked on this launch"。

想亲自体验的话，请在 [`Examples/CoffeeShop`](Examples/CoffeeShop) 中打开 `CoffeeShop.xcodeproj`，选择
**CoffeeShopClip** scheme 和一台 iPhone 模拟器，然后点击 **Run**。详情见 [Examples/README.md](Examples/README.md)。

## 文档

- [API 参考](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  （DocC，从 `master` 分支发布到 GitHub Pages）
- 在 Xcode 中通过 **Product › Build Documentation** 在本地构建，或使用命令行：

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## 指南

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — 把软件包添加到两个 target，路由调用并测试
  （[源文件](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md)）。
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — 检查了哪些内容、模式语法，以及哪条路由胜出
  （[源文件](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md)）。
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — Apple 的上限、大小报告和 `size` 命令
  （[源文件](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md)）。
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — entitlement 条目、`apple-app-site-association` 和 App Clip Code 的 URL
  （[源文件](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md)）。
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — 位置确认、App Store 覆盖层、通知和 `HandoffStore`
  （[源文件](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md)）。

## 系统要求

| 平台   | 最低版本                           |
| ------ | ---------------------------------- |
| iOS    | 16（位置确认和覆盖层仅限 iOS）     |
| macOS  | 13（命令行工具和与平台无关的检查） |
| 工具链 | Swift 6.2 · Xcode 26+              |

CI 使用 GitHub 的 `macos-26` runner 镜像自带的默认 Xcode 构建。该软件包使用 Xcode 27 开发。示例 App 的部署目标为 iOS 17。

## 架构

- `Sources/AppClipsStudio` 是库本身，每项任务一个文件夹：`Invocation`、`Routing`、`Size`、`AppClipCode`、`Association`、`Handoff`、`Location`
  和 `Promotion`。除 SwiftUI modifier 和 `APActivationPayload` 扩展外，其余全部是值类型和纯函数，因此在 macOS 上同样可以运行和测试。
- 错误是带类型的（`throws(InvocationError)`、`throws(ThinningReportError)` 等），调用方可以对每种情况进行 `switch`。
- `Sources/AppClipsStudioTool` 以库的形式提供命令行工具的各个命令，测试直接调用它们；`Sources/appclipstudio` 只负责转发参数。
- CI 在 macOS 上运行 `swift test`，在 iPhone 模拟器上运行 `xcodebuild test`，构建示例 App，并发布 DocC 文档。

在本地运行测试：

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## 路线图

- 把该软件包提交到 Swift Package Index；仓库中已有 `.spi.yml`。
- 直接从导出的 `.ipa` 读取大小，无需大小报告。
- 面向 App Store Connect API 的 App Clip 体验列表（按位置设置的高级体验）。

## 参与贡献

欢迎参与贡献。提交 pull request 之前，请先阅读[贡献指南](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md)和[行为准则](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md)。如发现安全问题，请按照[安全策略](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md)私下报告。

## 许可证

基于 MIT 许可证发布。详见 [LICENSE](LICENSE)。
