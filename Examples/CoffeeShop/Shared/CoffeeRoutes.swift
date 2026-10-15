import AppClipsStudio
import Foundation

/// The screens an invocation URL can open.
enum CoffeeScreen: Hashable, Sendable {
    case menu
    case drink(Drink)
    case table(Store, number: Int)
}

/// The invocation URLs this App Clip and its full app handle:
///
/// - `https://appclip.example.com/table/12?p=1`: table 12 in store 1 (an NFC tag on the table)
/// - `https://appclip.example.com/order?p=3`: drink 3 (an App Clip Code on a poster)
/// - `https://appclip.apple.com/id?p=io.github.muhittincamdali.CoffeeShop.Clip&drink=3`: the
///   default App Clip link with a launch parameter
/// - anything else on these hosts: the menu
enum CoffeeRoutes {
    static func makeRouter() throws -> InvocationRouter<CoffeeScreen> {
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
        return router
    }
}
