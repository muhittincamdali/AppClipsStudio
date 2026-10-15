<!-- i18n-source: README.md@9ad05c687cb5524941c112f26431f3c6a71ac750 status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-tr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-tr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/banner-tr-light.svg" alt="AppClipsStudio: iOS App Clip'leri için çağrı yönlendirme, boyut denetimi ve web sitesi ilişkilendirme."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="CI durumu"></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-version-light.svg" alt="Son sürüm: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-platforms-light.svg" alt="Desteklenen platformlar: iOS 16+ · macOS 13+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-language-light.svg" alt="Dil sürümü: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/blob/master/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/badge-license-light.svg" alt="Lisans: MIT"></picture></a>
</p>

<p align="center">
<a href="#hızlı-başlangıç"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-tr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-tr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-start-tr-light.svg" alt="Başlayın"></picture></a>
<a href="https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-tr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-tr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-docs-tr-light.svg" alt="Dokümantasyon"></picture></a>
<a href="https://github.com/muhittincamdali/AppClipsStudio/tree/master/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-tr-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-tr-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/AppClipsStudio/master/.github/brand/button-examples-tr-light.svg" alt="Örnekler"></picture></a>
</p>

> Bu belge İngilizce README'nin çevirisidir. İkisi arasında fark varsa güncel olan İngilizce sürümdür.

<!-- brand:end -->

iOS App Clip'leri ve ait oldukları uygulamalar için bir Swift paketi. Sistemin açılışta ilettiği
çağrı URL'sini doğrular ve App Store Connect'in onu App Clip deneyimlerine yönlendirdiği gibi
ekranlarınıza yönlendirir, kişinin kodun bulunduğu yerde olduğunu doğrular ve App Clip'in
verilerini tam uygulamaya aktarır. `appclipstudio` komut satırı aracı, yüklemeden önce App Store
Connect'in ve sistemin neleri denetleyeceğini kontrol eder: her varyantın boyutu, App Clip Code
URL'leri, `apple-app-site-association` dosyası ve Associated Domains girdileri. Paketin hiçbir
bağımlılığı yoktur.

## Öne çıkanlar

- **Apple'ın eşleştirme kuralıyla çağrı yönlendirme** — `/table/:number` ve `/shop/*` gibi
  desenler; App Store Connect'te olduğu gibi en spesifik önek kazanır ve bir fallback, kayıtlı
  bir önekin kalan kısmını karşılar; Apple bunun bir App Clip ve tam uygulaması tarafından
  işlenmesini şart koşar. Varsayılan App Clip bağlantıları (`https://appclip.apple.com/id?p=…`)
  tanınır.
- **Güvenilmeyen girdi sınırlı kalır** — çağrı URL'leri, kodunuz görmeden önce şema, host,
  uzunluk, yol ve sorgu boyutu ile `.`/`..` bileşenleri açısından denetlenir; sayılar çökmeden
  ayrıştırılır; boyut raporları `nan`, `inf` ve `1e999` değerlerini reddeder; dosyalar bir
  sınırla okunur; klasör taraması sembolik bağları izlemez; çıktı hiçbir zaman kontrol
  karakterlerini olduğu gibi yazmaz.
- **Varyant başına boyut denetimi** — Apple'ın 10, 15 ve 100 MB sınırları, Xcode'un
  `App Thinning Size Report.txt` dosyasındaki her varyanta iOS sürümü, dağıtım hedefi ve çağrı
  türüne göre uygulanır; CI için bir çıkış durumu döndürür.
- **Web sitesi ilişkilendirme** — `apple-app-site-association` dosyasını üretin ve doğrulayın,
  `appclips:`/`applinks:` entitlement girdilerini denetleyin ve App Clip Code URL'lerini
  Apple'ın kodlama kurallarına göre inceleyin.
- **Görevden sonraki an** — doğrulanmış 500 m'lik bir bölgeyle konum doğrulama, tam uygulama için
  App Store overlay'i ve paylaşılan App Group üzerinden tam uygulamaya sürümlü, süresi dolan,
  boyutu sınırlı bir değer ileten `HandoffStore`.
- **Test edilmiş** — macOS'ta ve bir iPhone simülatöründe 114 Swift Testing testi çalışır; bunlar
  yukarıdaki uç durumları ve aşağıdaki hızlı başlangıcı da kapsar.
- **Derlenen bir örnek** — [Examples/CoffeeShop](Examples/CoffeeShop), aynı kaynaklardan oluşan
  bir uygulama ve App Clip'idir; CI onu derler ve Kullanım bölümündeki örnekler ondan
  kopyalanmıştır.

## Hızlı başlangıç

**1. Paketi ekleyin**

Xcode'da **File › Add Package Dependencies…** menüsünü seçin ve depo adresini girin:

```text
https://github.com/muhittincamdali/AppClipsStudio.git
```

**Dependency Rule** ayarını `2.0.0` sürümünden başlayan **Up to Next Major Version** olarak
bırakın ve **Add Package**'a tıklayın. Sonraki pencerede **AppClipsStudio** yanında App Clip
hedefinizi seçin ve yeniden **Add Package**'a tıklayın. (Projenizde henüz App Clip yoksa **File
› New › Target… › App Clip** ile ekleyin; paketi tam uygulama hedefine de ekleyin.)

**2. Çağrıyı yönlendirin**

App Clip'inizin `ContentView.swift` dosyasının tüm içeriğini şununla değiştirin:

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

**3. Bir çağrı URL'siyle çalıştırın**

**Product › Scheme › Edit Scheme…** menüsünü seçin, **Run › Arguments** bölümüne gidin ve
`_XCAppClipURL` ortam değişkenini (Xcode bunu her App Clip şemasına ekler) şu değere ayarlayın:
`https://appclip.example.com/table/12`. Bir iPhone simülatörü seçin ve **Run**'a (⌘R) basın. App Clip "Table 12" gösterir; `/table/twelve` ile ya da yol olmadan "Scan a table
tag" gösterir.

Aynı kod
[`Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift`](Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift)
dosyasında derlenir ve test edilir.

## Kurulum

### Swift Package Manager

Kitaplığı, hızlı başlangıçtaki gibi Xcode'da App Clip ve tam uygulama hedeflerinize ya da
`Package.swift` içinde ekleyin:

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

### Komut satırı aracı

```sh
git clone https://github.com/muhittincamdali/AppClipsStudio.git
cd AppClipsStudio
swift build -c release
cp .build/release/appclipstudio /usr/local/bin/   # or run it with `swift run appclipstudio`
```

2.0.0 sürümü (Ekim 2026) bu kodun ilk sürümüdür. Önceki sürüm olan 1.0.0 (Şubat 2026), hiç
uygulanmamış modülleri anlatıyordu; Haziran 2026'da bunlar iskeletlere (stub) indirildi ve Ekim
2026'da paket, Apple'ın App Clip belgelerinden yola çıkılarak baştan yazıldı. Nelerin değiştiğini
[CHANGELOG.md](CHANGELOG.md) listeler.

## Kullanım

Aşağıdaki örnekler, CI'ın derlediği [`Examples/CoffeeShop`](Examples/CoffeeShop) örnek
uygulamasından kopyalanmıştır.

### Rotalar

[`Shared/CoffeeRoutes.swift`](Examples/CoffeeShop/Shared/CoffeeRoutes.swift) dosyasından: bir masa
etiketi, bir poster kodu ve varsayılan App Clip bağlantısı; diğer tüm URL'ler için menü.

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

`nil` döndüren bir işleyici (bilinmeyen bir mağaza, aralık dışı bir masa numarası) sıradaki
rotanın denemesine, en sonunda da fallback'e izin verir.

### URL olmadan açılışlar

[`Shared/CoffeeModel.swift`](Examples/CoffeeShop/Shared/CoffeeModel.swift) dosyasından. Bir
bildirimden ya da App Switcher'dan dönen kişi App Clip'i URL olmadan açar; bu yüzden her çağrı
kaydedilir ve geri yüklenir:

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

### Konum doğrulama ve App Store overlay'i

[`Shared/RootView.swift`](Examples/CoffeeShop/Shared/RootView.swift) dosyasından, yalnızca App Clip
için (`APPCLIP` derleme koşulu):

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

Her mağazanın `location` değeri bir `ExpectedLocation`'dır; bu tür yalnızca aralık içindeki sonlu
koordinatları ve 0'dan büyük, en fazla 500 metrelik (Apple'ın sınırı) bir yarıçapı kabul eder.

### Siparişi tam uygulamaya devretme

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

`handoff`, App Group'un `UserDefaults` suite'i üzerindeki bir `HandoffStore<PlacedOrder>`'dır ve
iki hedef tarafından paylaşılır.

## Komut satırı aracı

Dışa aktarılmış bir App Clip'in her varyantını denetleyin (biri sınırı aşarsa çıkış durumu 1
olur):

```text
$ appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

App Clip Code'lar için URL'leri denetleyin:

```text
$ appclipstudio check-url https://www.example.com/products/
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

İlişkilendirme dosyasını üretin ve doğrulayın, entitlement girdilerini denetleyin:

```sh
appclipstudio aasa generate --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip --path "/table/*" > apple-app-site-association
appclipstudio aasa validate apple-app-site-association --app-clip ABCDE12345.com.example.MyApp.Clip
appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

Her komut `--json` alır. `appclipstudio help` seçenekleri listeler.

## Demo

Örnek App Clip, bir masa etiketi URL'si ve bir poster URL'siyle açıldığında:

| Masa etiketi (açık)                                                          | Masa etiketi (koyu)                                                         | Poster (açık)                                                         | Poster (koyu)                                                        |
| ---------------------------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------------------------------------- | -------------------------------------------------------------------- |
| ![Harbor Street'te 12 numaralı masa, açık tema](docs/images/table-light.png) | ![Harbor Street'te 12 numaralı masa, koyu tema](docs/images/table-dark.png) | ![Flat White poster teklifi, açık tema](docs/images/poster-light.png) | ![Flat White poster teklifi, koyu tema](docs/images/poster-dark.png) |

Ekran görüntüleri bir iPhone simülatöründe
[`scripts/capture-screenshots.sh`](scripts/capture-screenshots.sh) ile alınır. Simülatörde sistem
etkinleştirme payload'ı iletmez; bu yüzden rozette "Location not checked on this launch" yazar.

Kendiniz denemek için [`Examples/CoffeeShop`](Examples/CoffeeShop) içindeki
`CoffeeShop.xcodeproj` dosyasını açın, **CoffeeShopClip** şemasını ve bir iPhone simülatörünü
seçip **Run**'a basın. Ayrıntılar [Examples/README.md](Examples/README.md) dosyasındadır.

## Dokümantasyon

- [API başvurusu](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/)
  (DocC; `master` dalından GitHub Pages'e yayımlanır)
- Xcode'da **Product › Build Documentation** ile ya da komut satırından yerelde derleyin:

```sh
xcodebuild docbuild -scheme AppClipsStudio -destination 'generic/platform=iOS Simulator'
```

## Rehberler

- [Getting Started](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/gettingstarted)
  — paketi iki hedefe ekleyin, çağrıyı yönlendirin ve test edin
  ([kaynak](Sources/AppClipsStudio/AppClipsStudio.docc/GettingStarted.md)).
- [Routing Invocations](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/routinginvocations)
  — nelerin denetlendiği, desen sözdizimi ve hangi rotanın kazandığı
  ([kaynak](Sources/AppClipsStudio/AppClipsStudio.docc/RoutingInvocations.md)).
- [Checking App Clip Size](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/checkingappclipsize)
  — Apple'ın sınırları, boyut raporu ve `size` komutu
  ([kaynak](Sources/AppClipsStudio/AppClipsStudio.docc/CheckingAppClipSize.md)).
- [Associating Your Website](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/associatingyourwebsite)
  — entitlement girdileri, `apple-app-site-association` ve App Clip Code URL'leri
  ([kaynak](Sources/AppClipsStudio/AppClipsStudio.docc/AssociatingYourWebsite.md)).
- [Handing Off to the Full App](https://muhittincamdali.github.io/AppClipsStudio/documentation/appclipsstudio/handingofftothefullapp)
  — konum doğrulama, App Store overlay'i, bildirimler ve `HandoffStore`
  ([kaynak](Sources/AppClipsStudio/AppClipsStudio.docc/HandingOffToTheFullApp.md)).

## Gereksinimler

| Platform     | En düşük sürüm                                             |
| ------------ | ---------------------------------------------------------- |
| iOS          | 16 (konum doğrulama ve overlay yalnızca iOS'ta)            |
| macOS        | 13 (komut satırı aracı ve platformdan bağımsız denetimler) |
| Araç zinciri | Swift 6.2 · Xcode 26+                                      |

CI, GitHub'ın `macos-26` runner imajındaki varsayılan Xcode ile derler. Paket Xcode 27 ile
geliştirilir. Örnek uygulamanın hedefi iOS 17'dir.

## Mimari

- `Sources/AppClipsStudio` kitaplığın kendisidir; her görev için bir klasör içerir: `Invocation`,
  `Routing`, `Size`, `AppClipCode`, `Association`, `Handoff`, `Location` ve `Promotion`. SwiftUI
  modifier'ları ve `APActivationPayload` eklentisi dışındaki her şey değer türleri ve saf
  fonksiyonlardır; bu yüzden macOS'ta da çalışır ve test edilir.
- Hatalar tiplidir (`throws(InvocationError)`, `throws(ThinningReportError)`, …); böylece çağıranlar
  her durumu `switch` ile ele alabilir.
- `Sources/AppClipsStudioTool`, komut satırı aracının komutlarını bir kitaplık olarak barındırır;
  testler onları doğrudan çağırır. `Sources/appclipstudio` yalnızca argümanları iletir.
- CI, macOS'ta `swift test`, bir iPhone simülatöründe `xcodebuild test` çalıştırır, örnek uygulamayı
  derler ve DocC dokümantasyonunu yayımlar.

Testleri yerelde çalıştırın:

```sh
swift test                                    # macOS
xcodebuild test -scheme AppClipsStudio-Package \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Yol haritası

- Paketi Swift Package Index'e eklemek; `.spi.yml` depoda zaten var.
- Boyutları, boyut raporu olmadan doğrudan dışa aktarılmış bir `.ipa` dosyasından okumak.
- App Store Connect API için bir App Clip deneyim listesi (konum başına gelişmiş deneyimler).

## Katkıda bulunma

Katkılarınızı bekliyoruz. Pull request açmadan önce [katkı rehberini](https://github.com/muhittincamdali/AppClipsStudio/blob/master/CONTRIBUTING.md) ve [davranış kurallarını](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) okuyun. Güvenlik açıklarını [güvenlik politikasında](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md) anlatıldığı gibi gizli olarak bildirin.

## Lisans

MIT lisansıyla yayımlanmıştır. Ayrıntılar için [LICENSE](LICENSE) dosyasına bakın.
