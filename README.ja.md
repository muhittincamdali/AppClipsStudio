<!-- i18n-source: README.md@9ad05c687cb5524941c112f26431f3c6a71ac750 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-ja-light.svg" alt="AppClipsStudio: iOS App Clip のための呼び出しルーティング、サイズチェック、Web サイト関連付け。"></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="CI ステータス"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="最新バージョン: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="対応プラットフォーム: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="言語バージョン: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="ライセンス: MIT"></picture></a>
</p>

<p align="center">
<a href="#クイックスタート"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-ja-light.svg" alt="はじめる"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-ja-light.svg" alt="ドキュメント"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ja-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ja-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-ja-light.svg" alt="サンプル"></picture></a>
</p>

> このドキュメントは英語版 README の翻訳です。内容が異なる場合は英語版が最新です。

<!-- brand:end -->

iOS App Clip と、それが属するアプリのための Swift パッケージです。起動時にシステムが渡す呼び出し URL を検証し、App Store Connect が App Clip エクスペリエンスへ振り分けるのと同じ方法で、アプリの画面へルーティングします。さらに、利用者がコードのある場所にいることを確認し、App Clip のデータをフルアプリへ引き継ぎます。付属のコマンドラインツール `appclipstudio` は、アップロードの前に App Store Connect とシステムが確認する項目をチェックします。各バリアントのサイズ、App Clip Code の URL、`apple-app-site-association` ファイル、Associated Domains のエントリが対象です。パッケージに依存関係はありません。

## 主な特長

- **Apple のマッチングルールに沿った呼び出しルーティング** — `/table/:number` や `/shop/*` のようなパターンに対応します。App Store Connect と同じく最も具体的なプレフィックスが優先され、登録済みプレフィックスの残りのパスはフォールバックが受け持ちます。Apple は App Clip とフルアプリの両方にこの処理を求めています。デフォルトの App Clip リンク (`https://appclip.apple.com/id?p=…`) も認識します。
- **信頼できない入力を制限する** — 呼び出し URL は、コードに渡る前にスキーム、ホスト、長さ、パスとクエリのサイズ、`.`/`..` の要素が検査されます。数値の解析はクラッシュせず、サイズレポートは `nan`、`inf`、`1e999` を拒否します。ファイルは上限付きで読み込み、フォルダのスキャンはシンボリックリンクをたどらず、出力に制御文字をそのまま出すこともありません。
- **バリアントごとのサイズチェック** — Apple の 10 MB、15 MB、100 MB の上限を、Xcode の `App Thinning Size Report.txt` に含まれる各バリアントへ、iOS バージョン、デプロイメントターゲット、呼び出しの種類ごとに適用し、CI 用の終了ステータスを返します。
- **Web サイトの関連付け** — `apple-app-site-association` の生成と検証、`appclips:`/`applinks:` の entitlement エントリのチェック、Apple のエンコード規則に基づく App Clip Code URL の検査ができます。
- **タスクの直後の場面** — 検証済みの 500 m の範囲による位置の確認、フルアプリ向けの App Store オーバーレイ、そして共有 App Group を通じて、バージョン付き・期限付き・サイズ制限付きの値をフルアプリへ渡す `HandoffStore` を備えています。
- **テスト済み** — 114 件の Swift Testing テストを macOS と iPhone シミュレータで実行します。上記のエッジケースと、下のクイックスタートも含まれます。
- **ビルドできるサンプル** — [Examples/CoffeeShop](Examples/CoffeeShop) は、同じソースから作ったアプリとその App Clip です。CI でビルドしており、「使い方」のコード例もここからコピーしています。

## クイックスタート

**1. パッケージを追加する**

Xcode で **File › Add Package Dependencies…** を選び、リポジトリの URL を入力します。

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

**Dependency Rule** は `2.0.0` 以降の **Up to Next Major Version** のままにして、**Add Package** をクリックします。次のウィンドウで **AppClipsStudio** の横にある App Clip ターゲットを選び、もう一度 **Add Package** をクリックします。(プロジェクトに App Clip がまだない場合は、**File › New › Target… › App Clip** で追加してください。フルアプリのターゲットにもパッケージを追加します。)

**2. 呼び出しをルーティングする**

App Clip の `ContentView.swift` の内容をすべて次のコードに置き換えます。

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

**3. 呼び出し URL を指定して実行する**

**Product › Scheme › Edit Scheme…** を選び、**Run › Arguments** を開いて、環境変数 `_XCAppClipURL` (Xcode はすべての App Clip スキームに追加します) に次の値を設定します:
`https://appclip.example.com/table/12`.
iPhone シミュレータを選んで **Run** (⌘R) を押すと、App Clip は "Table 12" を表示します。`/table/twelve` を指定した場合やパスがない場合は "Scan a table tag" を表示します。

同じコードを [`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift) でコンパイルし、テストしています。

## インストール

### Swift Package Manager

クイックスタートのように Xcode で App Clip とフルアプリの両方のターゲットにライブラリを追加するか、`Package.swift` に次のように記述します。

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

### コマンドラインツール

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

バージョン 2.0.0 (2026 年 10 月) は、このコードの最初のリリースです。以前のリリース 1.0.0 (2026 年 2 月) は実装されていないモジュールを説明しており、2026 年 6 月にそれらはスタブに縮小され、2026 年 10 月に Apple の App Clip ドキュメントをもとにパッケージ全体を書き直しました。変更点は [CHANGELOG.md](CHANGELOG.md) にまとめています。

## 使い方

以下のコード例は、CI でビルドしているサンプルアプリ [`Examples/CoffeeShop`](Examples/CoffeeShop) からコピーしたものです。

### ルート

[`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift) より。テーブルタグ、ポスターのコード、デフォルトの App Clip リンクを扱い、それ以外のすべての URL はメニューを表示します。

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

ハンドラが `nil` を返した場合 (不明な店舗や範囲外のテーブル番号など) は、次のルートが試され、最後にフォールバックが使われます。

### URL なしの起動

[`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift) より。通知や App Switcher から戻ってきた利用者は、URL なしで App Clip を起動します。そのため、呼び出しのたびに保存して復元します。

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

### 位置の確認と App Store オーバーレイ

[`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift) より。App Clip 専用です (コンパイル条件 `APPCLIP`)。

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

各店舗の `location` は `ExpectedLocation` です。範囲内の有限な座標と、0 より大きく 500 メートル以下 (Apple の上限) の半径だけを受け付けます。

### 注文をフルアプリへ引き継ぐ

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

`handoff` は、App Group の `UserDefaults` スイート上にある `HandoffStore<PlacedOrder>` で、2 つのターゲットから共有されます。

## コマンドラインツール

エクスポートした App Clip の全バリアントをチェックします (上限を超えたバリアントがあると、終了ステータスは 1 になります)。

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

App Clip Code 用の URL をチェックします。

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

関連付けファイルを生成して検証し、entitlement のエントリをチェックします。

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

すべてのコマンドが `--json` を受け付けます。オプションの一覧は `appclipstudio help` で確認できます。

## デモ

サンプルの App Clip を、テーブルタグの URL とポスターの URL で開いた様子です。

| テーブルタグ (ライト)                                                  | テーブルタグ (ダーク)                                                 | ポスター (ライト)                                                  | ポスター (ダーク)                                                 |
| ---------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------------------------------------- |
| ![Harbor Street の 12 番テーブル、ライト](docs/images/table-light.png) | ![Harbor Street の 12 番テーブル、ダーク](docs/images/table-dark.png) | ![Flat White のポスター特典、ライト](docs/images/poster-light.png) | ![Flat White のポスター特典、ダーク](docs/images/poster-dark.png) |

スクリーンショットは [`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh) で iPhone シミュレータ上から取得しています。シミュレータではシステムがアクティベーションペイロードを渡さないため、バッジには "Location not checked on this launch" と表示されます。

自分で試すには、[`Examples/CoffeeShop`](Examples/CoffeeShop) の `CoffeeShop.xcodeproj` を開き、**CoffeeShopClip** スキームと iPhone シミュレータを選んで **Run** を押します。詳細は [Examples/README.md](Examples/README.md) を参照してください。

## ドキュメント

- [API リファレンス](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  (DocC。`master` から GitHub Pages に公開しています)
- Xcode の **Product › Build Documentation** でローカルにビルドするか、コマンドラインから実行します。

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## ガイド

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — 2 つのターゲットにパッケージを追加し、呼び出しをルーティングしてテストする
  ([ソース](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md))。
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — 何が検査されるか、パターンの構文、どのルートが優先されるか
  ([ソース](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md))。
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — Apple の上限、サイズレポート、`size` コマンド
  ([ソース](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md))。
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — entitlement のエントリ、`apple-app-site-association`、App Clip Code の URL
  ([ソース](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md))。
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — 位置の確認、App Store オーバーレイ、通知、`HandoffStore`
  ([ソース](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md))。

## 動作要件

| プラットフォーム | 最小バージョン                                                    |
| ---------------- | ----------------------------------------------------------------- |
| iOS              | 16 (位置の確認とオーバーレイは iOS のみ)                          |
| macOS            | 13 (コマンドラインツールと、プラットフォームに依存しないチェック) |
| ツールチェーン   | Swift 6.2 · Xcode 26+                                             |

CI は、GitHub の `macos-26` ランナーイメージに入っているデフォルトの Xcode でビルドします。パッケージは Xcode 27 で開発しています。サンプルアプリのターゲットは iOS 17 です。

## アーキテクチャ

- `Sources/AppClipsStudio` がライブラリ本体で、タスクごとに 1 つのフォルダに分かれています。`Invocation`、`Routing`、`Size`、`AppClipCode`、`Association`、`Handoff`、`Location`、`Promotion` です。SwiftUI のモディファイアと `APActivationPayload` の拡張を除くすべてが値型と純粋関数なので、macOS でも実行とテストができます。
- エラーは型付きです (`throws(InvocationError)`、`throws(ThinningReportError)` など)。そのため、呼び出し側はすべてのケースを `switch` で処理できます。
- `Sources/AppClipsStudioTool` にはコマンドラインツールのコマンドがライブラリとして含まれており、テストはそれを直接呼び出します。`Sources/appclipstudio` は引数を渡すだけです。
- CI は macOS で `swift test`、iPhone シミュレータで `xcodebuild test` を実行し、サンプルアプリをビルドして、DocC ドキュメントを公開します。

テストをローカルで実行するには:

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## ロードマップ

- パッケージを Swift Package Index に追加する。`.spi.yml` はすでにリポジトリにあります。
- サイズレポートを使わず、エクスポートした `.ipa` から直接サイズを読み取る。
- App Store Connect API 向けの App Clip エクスペリエンス一覧 (場所ごとの高度なエクスペリエンス)。

## コントリビューション

コントリビューションを歓迎します。pull request を作成する前に[コントリビューションガイド](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md)と[行動規範](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md)をお読みください。セキュリティ上の問題は[セキュリティポリシー](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md)に従って非公開で報告してください。

## ライセンス

MIT ライセンスで公開しています。詳細は [LICENSE](LICENSE) を参照してください。
