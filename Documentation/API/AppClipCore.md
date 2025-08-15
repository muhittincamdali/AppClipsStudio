# AppClipCore API Reference

The `AppClipCore` is the central orchestration system for AppClipsStudio, providing comprehensive App Clip lifecycle management, resource optimization, and performance monitoring.

## Overview

```swift
public actor AppClipCore
```

The core system that manages App Clip initialization, resource monitoring, performance optimization, and coordination between all AppClipsStudio modules.

## Key Features

- 📱 **App Clip Lifecycle Management**: Complete initialization and state management
- 🎯 **Resource Optimization**: 10MB bundle size monitoring and optimization
- ⚡ **Performance Monitoring**: Real-time metrics and optimization
- 🧠 **Memory Management**: Intelligent memory usage for constrained environments
- 🔄 **Background Task Handling**: Efficient background operations
- 📊 **Analytics Integration**: Performance metrics and user engagement

## Singleton Access

```swift
public static let shared = AppClipCore()
```

Access the shared AppClipCore instance throughout your App Clip.

**Example:**
```swift
let core = AppClipCore.shared
await core.initialize()
```

## Initialization

### Basic Initialization

```swift
public func initialize() async throws
```

Initializes the AppClipCore system with default configuration.

**Example:**
```swift
@main
struct MyAppClip: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try await AppClipCore.shared.initialize()
                }
        }
    }
}
```

### Configuration-Based Initialization

```swift
public func initialize(with configuration: AppClipConfiguration) async throws
```

Initializes with custom configuration for specific App Clip requirements.

**Example:**
```swift
let config = AppClipConfiguration(
    maxMemoryUsage: 8 * 1024 * 1024, // 8MB
    cachePolicy: .aggressive,
    analyticsEnabled: true,
    securityLevel: .strict
)

try await AppClipCore.shared.initialize(with: config)
```

### Quick Setup

```swift
public func quickSetup() async throws
```

Rapid initialization for simple App Clips with optimized defaults.

**Example:**
```swift
// Perfect for simple App Clips
try await AppClipCore.shared.quickSetup()
```

## Configuration Management

### App Clip Configuration

```swift
public struct AppClipConfiguration: Sendable {
    public var maxMemoryUsage: Int64
    public var maxBundleSize: Int64
    public var cachePolicy: CachePolicy
    public var analyticsEnabled: Bool
    public var securityLevel: SecurityLevel
    public var performanceMode: PerformanceMode
    public var backgroundTaskEnabled: Bool
}
```

**Default Values:**
```swift
public static let `default` = AppClipConfiguration(
    maxMemoryUsage: 10 * 1024 * 1024,  // 10MB
    maxBundleSize: 10 * 1024 * 1024,   // 10MB App Store limit
    cachePolicy: .balanced,
    analyticsEnabled: true,
    securityLevel: .standard,
    performanceMode: .balanced,
    backgroundTaskEnabled: true
)
```

### Environment-Specific Configurations

```swift
public static let development = AppClipConfiguration(
    maxMemoryUsage: 15 * 1024 * 1024,  // Allow more for debugging
    cachePolicy: .minimal,
    analyticsEnabled: false,
    securityLevel: .relaxed,
    performanceMode: .debug
)

public static let production = AppClipConfiguration(
    maxMemoryUsage: 8 * 1024 * 1024,   // Conservative for production
    cachePolicy: .aggressive,
    analyticsEnabled: true,
    securityLevel: .strict,
    performanceMode: .optimized
)
```

### Runtime Configuration Updates

```swift
public func updateConfiguration(_ configuration: AppClipConfiguration) async
```

Update configuration during runtime without reinitializing.

**Example:**
```swift
var newConfig = AppClipCore.shared.currentConfiguration
newConfig.performanceMode = .optimized
await AppClipCore.shared.updateConfiguration(newConfig)
```

## Resource Management

### Bundle Size Monitoring

```swift
public func getBundleSize() async -> Int64
```

Get the current App Clip bundle size in bytes.

**Example:**
```swift
let bundleSize = await AppClipCore.shared.getBundleSize()
let sizeMB = Double(bundleSize) / (1024 * 1024)

if sizeMB > 9.0 {
    print("⚠️ Bundle size approaching 10MB limit: \(String(format: "%.2f", sizeMB))MB")
}
```

### Memory Usage Monitoring

```swift
public func getMemoryUsage() async -> MemoryUsage
```

**Memory Usage Structure:**
```swift
public struct MemoryUsage: Sendable {
    public let current: Int64        // Current memory usage
    public let peak: Int64          // Peak memory usage
    public let available: Int64     // Available memory
    public let limit: Int64         // App Clip memory limit
    public let warningThreshold: Int64  // Warning threshold
    public let isNearLimit: Bool    // Is approaching limit
}
```

**Example:**
```swift
let memory = await AppClipCore.shared.getMemoryUsage()

if memory.isNearLimit {
    print("⚠️ Memory usage high: \(memory.current / 1024 / 1024)MB")
    await AppClipCore.shared.optimizeMemoryUsage()
}
```

### Resource Optimization

```swift
public func optimizeResources() async
```

Automatically optimize App Clip resources and memory usage.

**Example:**
```swift
// Periodic optimization
Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
    Task {
        await AppClipCore.shared.optimizeResources()
    }
}
```

### Cache Management

```swift
public func clearCache() async
public func getCacheSize() async -> Int64
public func setCachePolicy(_ policy: CachePolicy) async
```

**Cache Policies:**
```swift
public enum CachePolicy: Sendable {
    case minimal      // Minimal caching for maximum available memory
    case balanced     // Balanced caching and memory usage
    case aggressive   // Aggressive caching for performance
    case custom(Int64) // Custom cache size in bytes
}
```

**Example:**
```swift
// Get cache information
let cacheSize = await AppClipCore.shared.getCacheSize()
print("Cache size: \(cacheSize / 1024)KB")

// Clear cache if needed
if cacheSize > 2 * 1024 * 1024 { // If cache > 2MB
    await AppClipCore.shared.clearCache()
}

// Adjust cache policy
await AppClipCore.shared.setCachePolicy(.minimal)
```

## Performance Management

### Performance Mode

```swift
public enum PerformanceMode: Sendable {
    case debug        // Debug mode with logging
    case balanced     // Balanced performance and battery
    case optimized    // Maximum performance
    case battery      // Battery-optimized mode
}

public func setPerformanceMode(_ mode: PerformanceMode) async
```

**Example:**
```swift
// Optimize for battery life
await AppClipCore.shared.setPerformanceMode(.battery)

// Optimize for performance
await AppClipCore.shared.setPerformanceMode(.optimized)
```

### Performance Metrics

```swift
public func getPerformanceMetrics() async -> PerformanceMetrics
```

**Performance Metrics Structure:**
```swift
public struct PerformanceMetrics: Sendable {
    public let launchTime: TimeInterval      // App Clip launch time
    public let memoryEfficiency: Double     // Memory usage efficiency (0-1)
    public let cpuUsage: Double            // Current CPU usage percentage
    public let batteryImpact: BatteryImpact // Battery impact level
    public let networkEfficiency: Double   // Network usage efficiency
    public let cacheHitRate: Double       // Cache hit rate percentage
    public let userEngagement: Double     // User engagement score
}

public enum BatteryImpact: Sendable {
    case minimal, low, moderate, high
}
```

**Example:**
```swift
let metrics = await AppClipCore.shared.getPerformanceMetrics()

print("📊 Performance Report:")
print("Launch time: \(Int(metrics.launchTime * 1000))ms")
print("Memory efficiency: \(Int(metrics.memoryEfficiency * 100))%")
print("Battery impact: \(metrics.batteryImpact)")
```

### Launch Time Optimization

```swift
public func optimizeLaunchTime() async
public func measureLaunchTime() async -> TimeInterval
```

**Example:**
```swift
// Measure current launch time
let launchTime = await AppClipCore.shared.measureLaunchTime()

if launchTime > 2.0 { // If launch takes more than 2 seconds
    await AppClipCore.shared.optimizeLaunchTime()
}
```

## Background Task Management

### Background Task Registration

```swift
public func registerBackgroundTask(_ identifier: String, handler: @escaping () async -> Void) async
public func unregisterBackgroundTask(_ identifier: String) async
```

**Example:**
```swift
// Register analytics sync background task
await AppClipCore.shared.registerBackgroundTask("analytics_sync") {
    await AppClipAnalytics.shared.syncPendingEvents()
}

// Unregister when no longer needed
await AppClipCore.shared.unregisterBackgroundTask("analytics_sync")
```

### Background Task Execution

```swift
public func executeBackgroundTasks() async
public func getBackgroundTaskStatus() async -> [String: BackgroundTaskStatus]
```

**Example:**
```swift
// Execute all registered background tasks
await AppClipCore.shared.executeBackgroundTasks()

// Check status
let statuses = await AppClipCore.shared.getBackgroundTaskStatus()
for (identifier, status) in statuses {
    print("\(identifier): \(status)")
}
```

## State Management

### App Clip State

```swift
public enum AppClipState: Sendable {
    case initializing
    case ready
    case active
    case background
    case suspended
    case terminated
}

public func getCurrentState() async -> AppClipState
public func setState(_ state: AppClipState) async
```

**Example:**
```swift
let currentState = await AppClipCore.shared.getCurrentState()

switch currentState {
case .ready:
    // App Clip is ready for user interaction
    break
case .background:
    // Optimize for background state
    await AppClipCore.shared.optimizeForBackground()
    break
default:
    break
}
```

### State Change Notifications

```swift
public func onStateChange(_ handler: @escaping (AppClipState) -> Void) async
```

**Example:**
```swift
await AppClipCore.shared.onStateChange { state in
    switch state {
    case .background:
        // Pause non-essential operations
        print("App Clip moved to background")
    case .active:
        // Resume operations
        print("App Clip became active")
    default:
        break
    }
}
```

## Session Management

### Session Data

```swift
public func storeSessionData(_ data: [String: Any]) async
public func getSessionData(for key: String) async -> Any?
public func clearSessionData() async
```

**Example:**
```swift
// Store user preferences
await AppClipCore.shared.storeSessionData([
    "user_preference": "dark_mode",
    "last_action": "product_view",
    "session_start": Date()
])

// Retrieve session data
if let preference = await AppClipCore.shared.getSessionData(for: "user_preference") as? String {
    print("User preference: \(preference)")
}

// Clear session on logout
await AppClipCore.shared.clearSessionData()
```

### Session Metrics

```swift
public func getSessionMetrics() async -> SessionMetrics
```

**Session Metrics Structure:**
```swift
public struct SessionMetrics: Sendable {
    public let sessionId: String
    public let startTime: Date
    public let duration: TimeInterval
    public let actions: Int
    public let dataUsage: Int64
    public let memoryPeak: Int64
    public let isCompleted: Bool
}
```

**Example:**
```swift
let metrics = await AppClipCore.shared.getSessionMetrics()
print("Session duration: \(Int(metrics.duration)) seconds")
print("Actions performed: \(metrics.actions)")
```

## Health Monitoring

### Health Status

```swift
public func getHealthStatus() async -> HealthStatus
```

**Health Status Structure:**
```swift
public struct HealthStatus: Sendable {
    public let isHealthy: Bool
    public let memoryHealth: HealthLevel
    public let performanceHealth: HealthLevel
    public let securityHealth: HealthLevel
    public let issues: [HealthIssue]
    public let recommendations: [String]
}

public enum HealthLevel: Sendable {
    case excellent, good, fair, poor, critical
}

public struct HealthIssue: Sendable {
    public let severity: Severity
    public let category: Category
    public let description: String
    public let solution: String?
}
```

**Example:**
```swift
let health = await AppClipCore.shared.getHealthStatus()

if !health.isHealthy {
    print("⚠️ App Clip health issues detected:")
    for issue in health.issues {
        print("- \(issue.description)")
        if let solution = issue.solution {
            print("  Solution: \(solution)")
        }
    }
}
```

### Health Monitoring

```swift
public func enableHealthMonitoring() async
public func disableHealthMonitoring() async
public func getHealthReport() async -> HealthReport
```

**Example:**
```swift
// Enable continuous health monitoring
await AppClipCore.shared.enableHealthMonitoring()

// Get detailed health report
let report = await AppClipCore.shared.getHealthReport()
print("Health score: \(report.overallScore)/100")
```

## Integration with Other Modules

### Router Integration

```swift
public func integrateWithRouter(_ router: AppClipRouter) async
```

**Example:**
```swift
await AppClipCore.shared.integrateWithRouter(AppClipRouter.shared)
```

### Analytics Integration

```swift
public func integrateWithAnalytics(_ analytics: AppClipAnalytics) async
```

**Example:**
```swift
await AppClipCore.shared.integrateWithAnalytics(AppClipAnalytics.shared)
```

### Security Integration

```swift
public func integrateWithSecurity(_ security: AppClipSecurity) async
```

**Example:**
```swift
await AppClipCore.shared.integrateWithSecurity(AppClipSecurity.shared)
```

## App Store Compliance

### Compliance Checking

```swift
public func checkAppStoreCompliance() async -> ComplianceReport
```

**Compliance Report Structure:**
```swift
public struct ComplianceReport: Sendable {
    public let overallCompliance: Bool
    public let bundleSizeCompliant: Bool
    public let performanceCompliant: Bool
    public let privacyCompliant: Bool
    public let accessibilityCompliant: Bool
    public let issues: [ComplianceIssue]
    public let score: Int // 0-100
}
```

**Example:**
```swift
let compliance = await AppClipCore.shared.checkAppStoreCompliance()

if !compliance.overallCompliance {
    print("❌ App Store compliance issues:")
    for issue in compliance.issues {
        print("- \(issue.description)")
    }
} else {
    print("✅ App Clip is App Store compliant (Score: \(compliance.score)/100)")
}
```

### Size Optimization for App Store

```swift
public func optimizeForAppStore() async
public func generateAppStoreReport() async -> AppStoreReport
```

**Example:**
```swift
// Optimize for App Store submission
await AppClipCore.shared.optimizeForAppStore()

// Generate report for App Store review
let report = await AppClipCore.shared.generateAppStoreReport()
print("Bundle size: \(report.bundleSizeMB)MB")
print("Launch time: \(report.launchTimeMs)ms")
```

## Advanced Features

### Custom Optimization Rules

```swift
public func addOptimizationRule(_ rule: OptimizationRule) async
public func removeOptimizationRule(_ identifier: String) async
```

**Optimization Rule Example:**
```swift
struct MemoryOptimizationRule: OptimizationRule {
    let identifier = "memory_optimization"
    
    func shouldTrigger(for metrics: PerformanceMetrics) -> Bool {
        return metrics.memoryEfficiency < 0.8
    }
    
    func execute() async {
        await AppClipCore.shared.clearCache()
        // Custom memory optimization logic
    }
}

await AppClipCore.shared.addOptimizationRule(MemoryOptimizationRule())
```

### Debug and Development

```swift
public func enableDebugMode() async
public func disableDebugMode() async
public func getDebugInformation() async -> DebugInfo
```

**Example:**
```swift
#if DEBUG
await AppClipCore.shared.enableDebugMode()

let debugInfo = await AppClipCore.shared.getDebugInformation()
print("Debug Info: \(debugInfo)")
#endif
```

### Performance Profiling

```swift
public func startProfiling() async
public func stopProfiling() async -> ProfilingReport
```

**Example:**
```swift
// Start profiling user interaction
await AppClipCore.shared.startProfiling()

// User performs actions...

// Stop profiling and get report
let report = await AppClipCore.shared.stopProfiling()
print("Profiling results: \(report.summary)")
```

## Error Handling

### Core Errors

```swift
public enum AppClipCoreError: LocalizedError {
    case initializationFailed(String)
    case configurationInvalid(String)
    case resourceLimitExceeded(String)
    case bundleSizeExceeded(Int64)
    case memoryLimitExceeded(Int64)
    case performanceDegraded(String)
    case backgroundTaskFailed(String)
    case healthCheckFailed(String)
    
    public var errorDescription: String? {
        switch self {
        case .initializationFailed(let reason):
            return "App Clip initialization failed: \(reason)"
        case .configurationInvalid(let reason):
            return "Invalid configuration: \(reason)"
        case .resourceLimitExceeded(let reason):
            return "Resource limit exceeded: \(reason)"
        case .bundleSizeExceeded(let size):
            return "Bundle size exceeded: \(size) bytes"
        case .memoryLimitExceeded(let usage):
            return "Memory limit exceeded: \(usage) bytes"
        case .performanceDegraded(let reason):
            return "Performance degraded: \(reason)"
        case .backgroundTaskFailed(let identifier):
            return "Background task failed: \(identifier)"
        case .healthCheckFailed(let reason):
            return "Health check failed: \(reason)"
        }
    }
}
```

### Error Handling Best Practices

```swift
do {
    try await AppClipCore.shared.initialize()
} catch AppClipCoreError.bundleSizeExceeded(let size) {
    print("Bundle too large: \(size) bytes. Optimizing...")
    await AppClipCore.shared.optimizeForAppStore()
} catch AppClipCoreError.memoryLimitExceeded(let usage) {
    print("Memory usage too high: \(usage) bytes. Cleaning up...")
    await AppClipCore.shared.optimizeMemoryUsage()
} catch {
    print("Unexpected error: \(error.localizedDescription)")
}
```

## Testing Support

### Mock Configuration

```swift
public static let testing = AppClipConfiguration(
    maxMemoryUsage: 50 * 1024 * 1024,  // Generous for testing
    maxBundleSize: 50 * 1024 * 1024,
    cachePolicy: .minimal,
    analyticsEnabled: false,
    securityLevel: .relaxed,
    performanceMode: .debug,
    backgroundTaskEnabled: false
)
```

### Test Utilities

```swift
public func resetForTesting() async
public func setTestMode(_ enabled: Bool) async
public func injectTestConfiguration(_ config: AppClipConfiguration) async
```

**Example:**
```swift
class AppClipCoreTests: XCTestCase {
    override func setUp() async throws {
        await AppClipCore.shared.setTestMode(true)
        await AppClipCore.shared.injectTestConfiguration(.testing)
    }
    
    override func tearDown() async throws {
        await AppClipCore.shared.resetForTesting()
    }
    
    func testInitialization() async throws {
        try await AppClipCore.shared.initialize()
        let state = await AppClipCore.shared.getCurrentState()
        XCTAssertEqual(state, .ready)
    }
}
```

## Best Practices

### Initialization

```swift
// ✅ Good: Initialize early in app lifecycle
@main
struct MyAppClip: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try await AppClipCore.shared.initialize()
                }
        }
    }
}

// ❌ Bad: Late initialization
struct ContentView: View {
    var body: some View {
        Text("Loading...")
            .onAppear {
                Task {
                    try await AppClipCore.shared.initialize()
                }
            }
    }
}
```

### Resource Management

```swift
// ✅ Good: Regular monitoring
Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
    Task {
        let memory = await AppClipCore.shared.getMemoryUsage()
        if memory.isNearLimit {
            await AppClipCore.shared.optimizeResources()
        }
    }
}

// ❌ Bad: No monitoring
// Not monitoring memory usage at all
```

### Performance Optimization

```swift
// ✅ Good: Environment-specific configuration
#if DEBUG
let config = AppClipConfiguration.development
#else
let config = AppClipConfiguration.production
#endif

await AppClipCore.shared.initialize(with: config)

// ❌ Bad: One-size-fits-all configuration
await AppClipCore.shared.initialize() // Using defaults everywhere
```

---

## See Also

- [AppClipRouter](./AppClipRouter.md)
- [AppClipAnalytics](./AppClipAnalytics.md)
- [AppClipSecurity](./AppClipSecurity.md)
- [Performance Optimization](../Performance.md)
- [App Store Guidelines](../AppStore.md)
- [Testing Guide](../Testing.md)