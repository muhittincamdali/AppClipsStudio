import AppClipsStudio
import SwiftUI
#if APPCLIP
import AppClip
#endif

/// The screen both targets show. App Clip-only parts are behind the `APPCLIP` compilation
/// condition, as Apple recommends for code shared between an App Clip and its app.
struct RootView: View {
    @State private var model = CoffeeModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ContextCard(model: model)
                    if let order = model.importedOrder {
                        ImportedOrderCard(order: order)
                    }
                    if let order = model.placedOrder {
                        PlacedOrderCard(order: order)
                    }
                    MenuSection(model: model)
                }
                .padding()
            }
            .background(Theme.background.ignoresSafeArea())
            .safeAreaInset(edge: .bottom) {
                if !model.cart.isEmpty {
                    CartBar(model: model)
                }
            }
            .navigationTitle("Coffee Shop")
        }
        .tint(Theme.accent)
        .task {
            model.restoreIfNeeded()
            #if !APPCLIP
            model.importHandoff()
            #endif
        }
        #if APPCLIP
        .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
            guard let invocation = try? Invocation(userActivity: activity) else { return }
            model.handle(invocation)
            if let payload = activity.appClipActivationPayload {
                Task { await model.confirmLocation(with: payload) }
            }
        }
        .fullAppOverlay(isPresented: $model.showsFullAppOverlay)
        #else
        .onInvocation(perform: model.handle)
        #endif
    }
}

enum Theme {
    static let accent = Color(red: 0, green: 0.443, blue: 0.890)
    static let accentLight = Color(red: 0.353, green: 0.784, blue: 0.980)
    static let background = Color(uiColor: .systemGroupedBackground)
    static let card = Color(uiColor: .secondarySystemGroupedBackground)
}

private struct ContextCard: View {
    let model: CoffeeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            switch model.screen {
            case .table(let store, let number):
                Label("Table \(number) · \(store.name)", systemImage: "chair.lounge.fill")
                    .font(.title3.weight(.semibold))
                LocationBadge(confirmation: model.confirmation)
            case .drink(let drink):
                Label("Poster offer: \(drink.name)", systemImage: drink.symbol)
                    .font(.title3.weight(.semibold))
                Text(drink.detail).foregroundStyle(.white.opacity(0.85))
            case .menu:
                Label("Order ahead", systemImage: "bag.fill")
                    .font(.title3.weight(.semibold))
                Text("Pick a drink and collect it at the counter.").foregroundStyle(.white.opacity(0.85))
            }
            if let rejection = model.rejection {
                Text("Ignored an invalid link: \(String(describing: rejection))")
                    .font(.footnote).foregroundStyle(.red)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .foregroundStyle(.white)
        .background(LinearGradient(colors: [Theme.accent, Theme.accentLight], startPoint: .topLeading, endPoint: .bottomTrailing), in: .rect(cornerRadius: 20))
    }
}

private struct LocationBadge: View {
    let confirmation: LocationConfirmation?

    var body: some View {
        Label(text, systemImage: symbol)
            .font(.footnote.weight(.medium))
            .padding(.horizontal, 10).padding(.vertical, 5)
            .background(.white.opacity(0.2), in: .capsule)
    }

    private var text: String {
        switch confirmation {
        case .confirmed: "Location confirmed"
        case .notInRegion: "You seem to be elsewhere"
        case .urlNotRegistered: "This tag isn't registered"
        case .unavailable: "Location check unavailable"
        case .failed: "Location check failed"
        case nil: "Location not checked on this launch"
        }
    }

    private var symbol: String {
        confirmation == .confirmed ? "location.fill" : "location.slash"
    }
}

private struct MenuSection: View {
    let model: CoffeeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Menu").font(.headline)
            ForEach(Catalog.drinks) { drink in
                HStack(spacing: 14) {
                    Image(systemName: drink.symbol)
                        .font(.title2).foregroundStyle(Theme.accent)
                        .frame(width: 44, height: 44)
                        .background(Theme.accent.opacity(0.12), in: .rect(cornerRadius: 12))
                    VStack(alignment: .leading, spacing: 2) {
                        Text(drink.name).font(.body.weight(.semibold))
                        Text(drink.price).font(.subheadline).foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("Add", systemImage: "plus") { model.add(drink) }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.circle)
                        .accessibilityLabel("Add \(drink.name)")
                }
                .padding(12)
                .background(highlight(drink), in: .rect(cornerRadius: 16))
            }
        }
    }

    private func highlight(_ drink: Drink) -> Color {
        if case .drink(let featured) = model.screen, featured == drink {
            return Theme.accent.opacity(0.15)
        }
        return Theme.card
    }
}

private struct CartBar: View {
    let model: CoffeeModel

    var body: some View {
        Button {
            model.placeOrder()
        } label: {
            Text("Order \(model.cart.count) · \(model.cartTotal)")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .background(.bar)
    }
}

private struct PlacedOrderCard: View {
    let order: PlacedOrder

    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 4) {
                Text("Order placed").font(.headline)
                Text("\(order.drinkIDs.count) drinks. The full app will show this order after it is installed.")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
        } icon: {
            Image(systemName: "checkmark.circle.fill").foregroundStyle(Theme.accent).font(.title2)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card, in: .rect(cornerRadius: 16))
    }
}

private struct ImportedOrderCard: View {
    let order: PlacedOrder

    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome to the full app").font(.headline)
                Text("Your App Clip order of \(order.drinkIDs.count) drinks moved over with you.")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
        } icon: {
            Image(systemName: "arrow.down.app.fill").foregroundStyle(Theme.accent).font(.title2)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card, in: .rect(cornerRadius: 16))
    }
}
