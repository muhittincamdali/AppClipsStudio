#if canImport(SwiftUI)
import AppClipsStudio
import Foundation
import SwiftUI
import Testing

// The quick start in README.md, copied verbatim, so it keeps compiling.
// README quick start: begin
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
// README quick start: end

@Suite("README quick start")
struct ReadmeQuickStartTests {
    @Test @MainActor func routesTheQuickStartURLs() throws {
        #expect(try ContentView.router.route(#require(URL(string: "https://appclip.example.com/table/12"))) == .table(12))
        #expect(try ContentView.router.route(#require(URL(string: "https://appclip.example.com/table/twelve"))) == .welcome)
        #expect(try ContentView.router.route(#require(URL(string: "https://appclip.example.com"))) == .welcome)
    }
}
#endif
