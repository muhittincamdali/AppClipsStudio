import AppClipsStudio
import Foundation

/// A drink on the menu. Prices are in cents.
struct Drink: Identifiable, Hashable, Sendable {
    let id: Int
    let name: String
    let detail: String
    let priceInCents: Int
    let symbol: String

    var price: String {
        (Decimal(priceInCents) / 100).formatted(.currency(code: "EUR"))
    }
}

/// A shop with tables that carry NFC tags or App Clip Codes.
struct Store: Identifiable, Hashable, Sendable {
    let id: Int
    let name: String
    let location: ExpectedLocation
}

/// The sample data. A real App Clip would load it from a server.
enum Catalog {
    static let drinks = [
        Drink(id: 1, name: "Espresso", detail: "A double shot of the house blend.", priceInCents: 300, symbol: "cup.and.saucer.fill"),
        Drink(id: 2, name: "Cappuccino", detail: "Espresso, steamed milk and foam.", priceInCents: 420, symbol: "mug.fill"),
        Drink(id: 3, name: "Flat White", detail: "Two ristretto shots with silky milk.", priceInCents: 450, symbol: "mug"),
        Drink(id: 4, name: "Iced Latte", detail: "Espresso over ice and cold milk.", priceInCents: 480, symbol: "takeoutbag.and.cup.and.straw.fill"),
        Drink(id: 5, name: "Matcha Latte", detail: "Ceremonial matcha with oat milk.", priceInCents: 500, symbol: "leaf.fill")
    ]

    // The coordinates are checked when the catalog loads; a typo fails loudly in development.
    static let stores = [
        Store(id: 1, name: "Harbor Street", location: try! ExpectedLocation(latitude: 41.0255, longitude: 28.9744, radius: 150, identifier: "store-1")),
        Store(id: 2, name: "Old Town", location: try! ExpectedLocation(latitude: 41.0086, longitude: 28.9802, radius: 150, identifier: "store-2"))
    ]

    static func drink(id: Int) -> Drink? {
        drinks.first { $0.id == id }
    }

    static func store(id: Int) -> Store? {
        stores.first { $0.id == id }
    }
}
