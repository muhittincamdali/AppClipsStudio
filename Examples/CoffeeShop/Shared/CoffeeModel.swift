import AppClipsStudio
import Foundation
import Observation
#if APPCLIP
import AppClip
#endif

/// An order the App Clip hands to the full app.
struct PlacedOrder: Codable, Sendable, Equatable {
    var drinkIDs: [Int]
    var storeID: Int?
    var table: Int?
    var placedAt: Date
}

/// The state both targets share: the current screen, the cart and the last order.
@MainActor
@Observable
final class CoffeeModel {
    static let appGroup = "group.io.github.muhittincamdali.CoffeeShop"

    private(set) var screen: CoffeeScreen = .menu
    private(set) var cart: [Drink] = []
    private(set) var placedOrder: PlacedOrder?
    private(set) var importedOrder: PlacedOrder?
    private(set) var confirmation: LocationConfirmation?
    private(set) var rejection: InvocationError?
    var showsFullAppOverlay = false

    private let router: InvocationRouter<CoffeeScreen>
    private let lastInvocation: LastInvocationStore
    private let handoff: HandoffStore<PlacedOrder>?

    init() {
        // The routes are fixed in code; a bad pattern is a programming error.
        do {
            router = try CoffeeRoutes.makeRouter()
        } catch {
            fatalError("Invalid route pattern: \(error)")
        }
        let shared = UserDefaults(suiteName: Self.appGroup) ?? .standard
        lastInvocation = LastInvocationStore(defaults: shared)
        handoff = HandoffStore(defaults: shared, key: "placedOrder")
    }

    var cartTotal: String {
        (Decimal(cart.map(\.priceInCents).reduce(0, +)) / 100).formatted(.currency(code: "EUR"))
    }

    /// Opens the screen for an invocation and remembers it for launches without a URL.
    func handle(_ invocation: Invocation) {
        do {
            screen = try router.route(invocation) ?? .menu
            lastInvocation.save(invocation)
            rejection = nil
        } catch {
            rejection = error
        }
    }

    /// Restores the last invocation, for launches from a notification or the App Switcher.
    func restoreIfNeeded() {
        #if DEBUG
        // `-demoURL <url>` opens a URL on launch, for screenshots from the command line.
        if let text = UserDefaults.standard.string(forKey: "demoURL"), let url = URL(string: text) {
            do {
                handle(try Invocation(url: url))
            } catch {
                rejection = error
            }
            return
        }
        #endif
        if let invocation = lastInvocation.load() {
            handle(invocation)
        }
    }

    func add(_ drink: Drink) {
        cart.append(drink)
    }

    func open(_ screen: CoffeeScreen) {
        self.screen = screen
    }

    /// Places the order and leaves it for the full app for 30 days.
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

    #if APPCLIP
    /// Asks the system whether the invocation happened at the table's store.
    func confirmLocation(with payload: APActivationPayload) async {
        guard case .table(let store, _) = screen else { return }
        confirmation = await payload.confirm(store.location)
    }
    #endif
}
