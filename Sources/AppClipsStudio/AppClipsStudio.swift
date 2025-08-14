// AppClipsStudio.swift
// App Clips Studio - The Ultimate App Clips Development Framework
//
// Copyright (c) 2024 App Clips Studio
// Licensed under MIT License

import Foundation
import SwiftUI
import AppClip
import AppClipCore
import AppClipRouter
import AppClipAnalytics
import AppClipUI
import AppClipNetworking
import AppClipStorage

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

/// The main entry point for App Clips Studio framework
/// Provides a unified interface for all App Clip development needs
@available(iOS 14.0, macOS 11.0, watchOS 7.0, tvOS 14.0, visionOS 1.0, *)
public final class AppClipsStudio {
    
    // MARK: - Singleton Instance
    
    /// Shared instance of App Clips Studio
    public static let shared = AppClipsStudio()
    
    // MARK: - Core Components
    
    /// App Clip core management system
    public let core: AppClipManager
    
    /// URL routing and deep linking system
    public let router: AppClipRouter
    
    /// Analytics and performance tracking
    public let analytics: AppClipAnalytics
    
    /// UI components and themes
    public let ui: AppClipUIManager
    
    /// Networking and API management
    public let networking: AppClipNetworking
    
    /// Storage and persistence layer
    public let storage: AppClipStorage
    
    // MARK: - Configuration
    
    /// Current framework configuration
    public private(set) var configuration: AppClipsStudioConfiguration
    
    /// Framework version information
    public static let version = AppClipsStudioVersion.current
    
    // MARK: - Initialization
    
    private init() {
        self.configuration = AppClipsStudioConfiguration()
        
        // Initialize core components
        self.core = AppClipManager(configuration: configuration.coreConfig)
        self.router = AppClipRouter(configuration: configuration.routerConfig)
        self.analytics = AppClipAnalytics(configuration: configuration.analyticsConfig)
        self.ui = AppClipUIManager(configuration: configuration.uiConfig)
        self.networking = AppClipNetworking(configuration: configuration.networkingConfig)
        self.storage = AppClipStorage(configuration: configuration.storageConfig)
        
        // Setup component connections
        setupComponentConnections()
        
        // Initialize framework
        initializeFramework()
    }
    
    // MARK: - Public Configuration Methods
    
    /// Configure the App Clips Studio framework
    /// - Parameter configuration: The configuration to apply
    public func configure(with configuration: AppClipsStudioConfiguration) {
        self.configuration = configuration
        
        // Update all components with new configuration
        core.updateConfiguration(configuration.coreConfig)
        router.updateConfiguration(configuration.routerConfig)
        analytics.updateConfiguration(configuration.analyticsConfig)
        ui.updateConfiguration(configuration.uiConfig)
        networking.updateConfiguration(configuration.networkingConfig)
        storage.updateConfiguration(configuration.storageConfig)
        
        AppClipLogger.info("App Clips Studio configured successfully")
    }
    
    /// Quick setup for common App Clip scenarios
    /// - Parameters:
    ///   - appClipURL: The App Clip's invocation URL
    ///   - bundleIdentifier: The App Clip's bundle identifier
    ///   - parentAppIdentifier: The parent app's bundle identifier
    public func quickSetup(
        appClipURL: URL,
        bundleIdentifier: String,
        parentAppIdentifier: String
    ) {
        let quickConfig = AppClipsStudioConfiguration.quick(
            appClipURL: appClipURL,
            bundleIdentifier: bundleIdentifier,
            parentAppIdentifier: parentAppIdentifier
        )
        
        configure(with: quickConfig)
        
        AppClipLogger.info("App Clips Studio quick setup completed for: \(bundleIdentifier)")
    }
    
    // MARK: - App Clip Lifecycle Management
    
    /// Initialize the App Clip with the given URL
    /// - Parameter url: The invocation URL
    public func initializeAppClip(with url: URL) async throws {
        AppClipLogger.info("Initializing App Clip with URL: \(url)")
        
        // Start analytics session
        await analytics.startSession(url: url)
        
        // Process the invocation URL
        let routingResult = try await router.processInvocation(url: url)
        
        // Initialize core with routing result
        try await core.initialize(with: routingResult)
        
        // Setup UI based on routing
        await ui.setupForRouting(routingResult)
        
        AppClipLogger.info("App Clip initialization completed successfully")
    }
    
    /// Handle App Clip URL continuation
    /// - Parameter userActivity: The NSUserActivity containing the URL
    public func continueUserActivity(_ userActivity: NSUserActivity) async throws {
        guard let url = userActivity.webpageURL else {
            throw AppClipError.invalidURL("No webpage URL found in user activity")
        }
        
        try await initializeAppClip(with: url)
    }
    
    /// Prepare for transitioning to the full app
    public func prepareForTransition() async {
        AppClipLogger.info("Preparing for transition to full app")
        
        // Save current state
        await storage.saveCurrentState()
        
        // Track transition event
        await analytics.trackTransition()
        
        // Cleanup resources
        await cleanup()
    }
    
    // MARK: - Utility Methods
    
    /// Check if running in App Clip context
    public static var isRunningInAppClip: Bool {
        #if APPCLIP
        return true
        #else
        return Bundle.main.bundleURL.pathExtension == "appex"
        #endif
    }
    
    /// Get the parent app's bundle identifier
    public var parentAppBundleIdentifier: String? {
        guard Self.isRunningInAppClip else { return nil }
        
        let appClipBundleId = Bundle.main.bundleIdentifier ?? ""
        let components = appClipBundleId.components(separatedBy: ".")
        
        if let clipIndex = components.lastIndex(of: "Clip") {
            return components[0..<clipIndex].joined(separator: ".")
        }
        
        return nil
    }
    
    // MARK: - Private Methods
    
    private func setupComponentConnections() {
        // Connect router to analytics
        router.setAnalyticsHandler { [weak self] event in
            Task {
                await self?.analytics.track(event)
            }
        }
        
        // Connect networking to analytics
        networking.setAnalyticsHandler { [weak self] event in
            Task {
                await self?.analytics.track(event)
            }
        }
        
        // Connect core to storage
        core.setStorageHandler { [weak self] data in
            await self?.storage.store(data)
        }
        
        // Connect UI to analytics
        ui.setAnalyticsHandler { [weak self] event in
            Task {
                await self?.analytics.track(event)
            }
        }
    }
    
    private func initializeFramework() {
        AppClipLogger.info("Initializing App Clips Studio v\(Self.version.fullVersion)")
        
        // Register for system notifications
        #if canImport(UIKit) && !os(watchOS)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillTerminate),
            name: UIApplication.willTerminateNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        #endif
    }
    
    private func cleanup() async {
        AppClipLogger.info("Cleaning up App Clips Studio resources")
        
        await analytics.endSession()
        await storage.cleanup()
        await networking.cleanup()
        
        #if canImport(UIKit)
        NotificationCenter.default.removeObserver(self)
        #endif
    }
    
    // MARK: - System Notifications
    
    #if canImport(UIKit) && !os(watchOS)
    @objc private func appWillTerminate() {
        Task {
            await cleanup()
        }
    }
    
    @objc private func appDidEnterBackground() {
        Task {
            await storage.saveCurrentState()
            await analytics.pauseSession()
        }
    }
    #endif
}

// MARK: - App Clips Studio Configuration

/// Configuration for the entire App Clips Studio framework
public struct AppClipsStudioConfiguration {
    
    /// Core App Clip configuration
    public let coreConfig: AppClipCoreConfiguration
    
    /// Router configuration
    public let routerConfig: AppClipRouterConfiguration
    
    /// Analytics configuration
    public let analyticsConfig: AppClipAnalyticsConfiguration
    
    /// UI configuration
    public let uiConfig: AppClipUIConfiguration
    
    /// Networking configuration
    public let networkingConfig: AppClipNetworkingConfiguration
    
    /// Storage configuration
    public let storageConfig: AppClipStorageConfiguration
    
    /// Initialize with individual configurations
    public init(
        coreConfig: AppClipCoreConfiguration = AppClipCoreConfiguration(),
        routerConfig: AppClipRouterConfiguration = AppClipRouterConfiguration(),
        analyticsConfig: AppClipAnalyticsConfiguration = AppClipAnalyticsConfiguration(),
        uiConfig: AppClipUIConfiguration = AppClipUIConfiguration(),
        networkingConfig: AppClipNetworkingConfiguration = AppClipNetworkingConfiguration(),
        storageConfig: AppClipStorageConfiguration = AppClipStorageConfiguration()
    ) {
        self.coreConfig = coreConfig
        self.routerConfig = routerConfig
        self.analyticsConfig = analyticsConfig
        self.uiConfig = uiConfig
        self.networkingConfig = networkingConfig
        self.storageConfig = storageConfig
    }
    
    /// Quick configuration for common scenarios
    public static func quick(
        appClipURL: URL,
        bundleIdentifier: String,
        parentAppIdentifier: String
    ) -> AppClipsStudioConfiguration {
        let coreConfig = AppClipCoreConfiguration(
            bundleIdentifier: bundleIdentifier,
            parentAppIdentifier: parentAppIdentifier,
            invocationURL: appClipURL
        )
        
        let routerConfig = AppClipRouterConfiguration(
            baseURL: appClipURL,
            supportedSchemes: [appClipURL.scheme].compactMap { $0 }
        )
        
        let analyticsConfig = AppClipAnalyticsConfiguration(
            enabled: true,
            trackingLevel: .standard
        )
        
        return AppClipsStudioConfiguration(
            coreConfig: coreConfig,
            routerConfig: routerConfig,
            analyticsConfig: analyticsConfig
        )
    }
    
    /// Enterprise configuration with enhanced features
    public static func enterprise(
        appClipURL: URL,
        bundleIdentifier: String,
        parentAppIdentifier: String,
        apiKey: String? = nil
    ) -> AppClipsStudioConfiguration {
        let coreConfig = AppClipCoreConfiguration(
            bundleIdentifier: bundleIdentifier,
            parentAppIdentifier: parentAppIdentifier,
            invocationURL: appClipURL,
            performanceMode: .enterprise
        )
        
        let routerConfig = AppClipRouterConfiguration(
            baseURL: appClipURL,
            supportedSchemes: [appClipURL.scheme].compactMap { $0 },
            cachingStrategy: .aggressive
        )
        
        let analyticsConfig = AppClipAnalyticsConfiguration(
            enabled: true,
            trackingLevel: .comprehensive,
            apiKey: apiKey
        )
        
        let networkingConfig = AppClipNetworkingConfiguration(
            timeout: 15.0,
            retryPolicy: .exponentialBackoff(maxAttempts: 3),
            cachingEnabled: true
        )
        
        return AppClipsStudioConfiguration(
            coreConfig: coreConfig,
            routerConfig: routerConfig,
            analyticsConfig: analyticsConfig,
            networkingConfig: networkingConfig
        )
    }
}

// MARK: - Version Information

/// App Clips Studio version information
public struct AppClipsStudioVersion {
    public let major: Int
    public let minor: Int
    public let patch: Int
    public let build: String?
    
    public var fullVersion: String {
        let version = "\(major).\(minor).\(patch)"
        if let build = build {
            return "\(version)-\(build)"
        }
        return version
    }
    
    public static let current = AppClipsStudioVersion(
        major: 1,
        minor: 0,
        patch: 0,
        build: nil
    )
}

// MARK: - Public Extensions

extension AppClipsStudio {
    
    /// Create a SwiftUI View wrapper for App Clip content
    /// - Parameter content: The main App Clip content
    /// - Returns: A configured SwiftUI View
    public func createAppClipView<Content: View>(
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        AppClipViewWrapper(content: content)
            .environmentObject(self)
    }
}

/// SwiftUI View wrapper for App Clip content
private struct AppClipViewWrapper<Content: View>: View {
    let content: () -> Content
    @EnvironmentObject var appClipsStudio: AppClipsStudio
    
    var body: some View {
        content()
            .onAppear {
                Task {
                    await appClipsStudio.analytics.trackViewAppearance("AppClipMain")
                }
            }
    }
}