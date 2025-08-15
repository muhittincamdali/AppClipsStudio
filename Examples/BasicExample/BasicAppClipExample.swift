//
//  BasicAppClipExample.swift
//  AppClipsStudio Examples
//
//  Created by AppClipsStudio on 2024.
//  Copyright © 2024 AppClipsStudio. All rights reserved.
//

import SwiftUI
import AppClipsStudio

/// Basic App Clip example demonstrating core AppClipsStudio functionality
@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, visionOS 1.0, *)
struct BasicAppClipExample: View {
    @StateObject private var viewModel = AppClipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // App Clip Header
                    AppClipHeaderView()
                    
                    // Quick Actions
                    QuickActionsView(viewModel: viewModel)
                    
                    // Analytics Dashboard
                    AnalyticsDashboardView(viewModel: viewModel)
                    
                    // Security Status
                    SecurityStatusView(viewModel: viewModel)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("AppClipsStudio Demo")
        }
        .task {
            await viewModel.initialize()
        }
    }
}

// MARK: - Sub Views

struct AppClipHeaderView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "app.badge")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("AppClipsStudio Demo")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Comprehensive App Clip development framework")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
    }
}

struct QuickActionsView: View {
    @ObservedObject var viewModel: AppClipViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Actions")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                ActionButton(
                    title: "Process URL",
                    icon: "link",
                    action: { await viewModel.processURL() }
                )
                
                ActionButton(
                    title: "Store Data",
                    icon: "externaldrive",
                    action: { await viewModel.storeData() }
                )
                
                ActionButton(
                    title: "Track Event",
                    icon: "chart.line.uptrend.xyaxis",
                    action: { await viewModel.trackEvent() }
                )
                
                ActionButton(
                    title: "Security Check",
                    icon: "shield.checkered",
                    action: { await viewModel.performSecurityCheck() }
                )
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let action: () async -> Void
    
    @State private var isLoading = false
    
    var body: some View {
        Button {
            Task {
                isLoading = true
                await action()
                isLoading = false
            }
        } label: {
            VStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: icon)
                        .font(.title2)
                }
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
        }
        .disabled(isLoading)
    }
}

struct AnalyticsDashboardView: View {
    @ObservedObject var viewModel: AppClipViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Analytics Dashboard")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                MetricCard(
                    title: "Sessions",
                    value: "\(viewModel.analytics.totalSessions)",
                    change: "+12%"
                )
                
                MetricCard(
                    title: "Events",
                    value: "\(viewModel.analytics.totalEvents)",
                    change: "+8%"
                )
                
                MetricCard(
                    title: "Avg. Duration",
                    value: "\(Int(viewModel.analytics.averageDuration))s",
                    change: "+5%"
                )
                
                MetricCard(
                    title: "Conversion",
                    value: "\(String(format: "%.1f", viewModel.analytics.conversionRate))%",
                    change: "+15%"
                )
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let change: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(change)
                .font(.caption)
                .foregroundColor(.green)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct SecurityStatusView: View {
    @ObservedObject var viewModel: AppClipViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Security Status")
                .font(.headline)
            
            HStack {
                Image(systemName: viewModel.security.isSecure ? "checkmark.shield" : "exclamationmark.shield")
                    .foregroundColor(viewModel.security.isSecure ? .green : .red)
                    .font(.title2)
                
                VStack(alignment: .leading) {
                    Text(viewModel.security.isSecure ? "Secure" : "Security Issues")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Text("Threat Level: \(viewModel.security.threatLevel.rawValue.capitalized)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("\(Int(viewModel.security.securityScore * 100))%")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.security.isSecure ? .green : .red)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - ViewModel

@MainActor
final class AppClipViewModel: ObservableObject {
    @Published var analytics = AnalyticsData()
    @Published var security = SecurityData()
    @Published var isLoading = false
    @Published var statusMessage = ""
    
    private let appClipCore = AppClipCore.shared
    private let appClipRouter = AppClipRouter.shared
    private let appClipAnalytics = AppClipAnalytics.shared
    private let appClipSecurity = AppClipSecurity.shared
    
    func initialize() async {
        isLoading = true
        statusMessage = "Initializing AppClipsStudio..."
        
        do {
            // Initialize core systems
            await appClipCore.initialize()
            await appClipRouter.initialize()
            await appClipAnalytics.initialize()
            await appClipSecurity.initialize()
            
            // Load initial data
            await loadAnalytics()
            await loadSecurityStatus()
            
            statusMessage = "AppClipsStudio ready!"
        } catch {
            statusMessage = "Initialization failed: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func processURL() async {
        statusMessage = "Processing URL..."
        
        // Simulate URL processing
        let testURL = URL(string: "https://example.com/appclip?product=123")!
        await appClipRouter.processDeepLink(testURL)
        
        statusMessage = "URL processed successfully"
        await loadAnalytics()
    }
    
    func storeData() async {
        statusMessage = "Storing data..."
        
        // Simulate data storage
        let testData = ["user_id": "123", "session": "abc456"]
        await appClipCore.storeSessionData(testData)
        
        statusMessage = "Data stored successfully"
    }
    
    func trackEvent() async {
        statusMessage = "Tracking event..."
        
        // Simulate event tracking
        await appClipAnalytics.trackEvent("demo_action", properties: [
            "screen": "main",
            "action": "button_tap"
        ])
        
        statusMessage = "Event tracked successfully"
        await loadAnalytics()
    }
    
    func performSecurityCheck() async {
        statusMessage = "Performing security check..."
        
        // Simulate security check
        await appClipSecurity.performSecurityScan()
        await loadSecurityStatus()
        
        statusMessage = "Security check completed"
    }
    
    private func loadAnalytics() async {
        let metrics = await appClipAnalytics.getAnalyticsMetrics()
        analytics = AnalyticsData(
            totalSessions: Int(metrics.totalSessions),
            totalEvents: Int(metrics.totalEvents),
            averageDuration: metrics.averageSessionDuration,
            conversionRate: metrics.conversionRate * 100
        )
    }
    
    private func loadSecurityStatus() async {
        let securityMetrics = await appClipSecurity.getSecurityMetrics()
        security = SecurityData(
            isSecure: securityMetrics.overallScore > 0.8,
            threatLevel: mapThreatLevel(securityMetrics.threatLevel),
            securityScore: securityMetrics.overallScore
        )
    }
    
    private func mapThreatLevel(_ level: ThreatLevel) -> SecurityData.ThreatLevel {
        switch level {
        case .minimal: return .low
        case .low: return .low
        case .moderate: return .medium
        case .high: return .high
        case .critical: return .critical
        }
    }
}

// MARK: - Data Models

struct AnalyticsData {
    var totalSessions: Int = 0
    var totalEvents: Int = 0
    var averageDuration: TimeInterval = 0
    var conversionRate: Double = 0
}

struct SecurityData {
    var isSecure: Bool = true
    var threatLevel: ThreatLevel = .low
    var securityScore: Double = 1.0
    
    enum ThreatLevel: String {
        case low, medium, high, critical
    }
}

// MARK: - Advanced Examples

/// Advanced App Clip features demonstration
@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, visionOS 1.0, *)
final class AdvancedAppClipExample {
    private let core = AppClipCore.shared
    private let router = AppClipRouter.shared
    private let analytics = AppClipAnalytics.shared
    private let networking = AppClipNetworking.shared
    private let ui = AppClipUI.shared
    private let storage = AppClipStorage.shared
    private let security = AppClipSecurity.shared
    
    /// Demonstrate complete App Clip workflow
    func performCompleteWorkflow() async throws {
        // 1. Initialize App Clip
        await core.initialize()
        
        // 2. Process incoming URL
        let url = URL(string: "https://example.com/appclip?item=123&action=purchase")!
        await router.processDeepLink(url)
        
        // 3. Fetch data from API
        let itemData = try await networking.fetchData(from: "/api/items/123")
        
        // 4. Store session data
        await storage.store(key: "current_item", value: itemData)
        
        // 5. Track user interaction
        await analytics.trackEvent("item_viewed", properties: [
            "item_id": "123",
            "source": "appclip"
        ])
        
        // 6. Perform security validation
        await security.validateSession()
        
        // 7. Update UI
        await ui.updateInterface(with: itemData)
    }
    
    /// Demonstrate advanced analytics
    func setupAdvancedAnalytics() async {
        // Custom event tracking
        await analytics.trackEvent("app_clip_launched", properties: [
            "source": "qr_code",
            "campaign": "summer_2024",
            "user_type": "returning"
        ])
        
        // Funnel tracking
        await analytics.startFunnel("purchase_flow")
        await analytics.trackFunnelStep("product_view")
        await analytics.trackFunnelStep("add_to_cart")
        await analytics.completeFunnel("purchase_complete", value: 99.99)
        
        // User identification
        await analytics.identifyUser("user_123", traits: [
            "email": "user@example.com",
            "plan": "premium"
        ])
    }
    
    /// Demonstrate advanced routing
    func setupAdvancedRouting() async {
        // Register custom route handlers
        await router.registerHandler(for: "product") { parameters in
            await self.handleProductRoute(parameters)
        }
        
        await router.registerHandler(for: "purchase") { parameters in
            await self.handlePurchaseRoute(parameters)
        }
        
        // Set up URL validation
        await router.setURLValidator { url in
            return url.host == "example.com" && url.pathComponents.count >= 2
        }
    }
    
    /// Demonstrate advanced security
    func setupAdvancedSecurity() async {
        // Configure security policies
        await security.configurePolicy(.strict)
        
        // Set up threat monitoring
        await security.enableThreatMonitoring()
        
        // Configure data encryption
        await security.enableEncryption(algorithm: .aes256)
        
        // Set up access controls
        await security.setAccessPolicy(.authenticated)
    }
    
    // MARK: - Private Methods
    
    private func handleProductRoute(_ parameters: [String: String]) async {
        guard let productId = parameters["id"] else { return }
        
        // Load product data
        await analytics.trackEvent("product_route_handled", properties: [
            "product_id": productId
        ])
    }
    
    private func handlePurchaseRoute(_ parameters: [String: String]) async {
        guard let productId = parameters["id"] else { return }
        
        // Handle purchase flow
        await analytics.trackEvent("purchase_route_handled", properties: [
            "product_id": productId
        ])
    }
}

// MARK: - Preview

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, visionOS 1.0, *)
struct BasicAppClipExample_Previews: PreviewProvider {
    static var previews: some View {
        BasicAppClipExample()
    }
}