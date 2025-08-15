# Migration Guide - AppClipsStudio

## Overview

This comprehensive guide covers migration strategies for transitioning to AppClipsStudio from various sources including Widgets, existing App Clips implementations, and between different versions of AppClipsStudio.

## Table of Contents

1. [From iOS Widgets to App Clips](#from-ios-widgets-to-app-clips)
2. [From Basic App Clips to AppClipsStudio](#from-basic-app-clips-to-appclipsstudio)
3. [Version Migration](#version-migration)
4. [Data Migration Strategies](#data-migration-strategies)
5. [Code Migration Tools](#code-migration-tools)

## From iOS Widgets to App Clips

### Understanding the Differences

| Aspect | Widget | App Clip |
|--------|--------|----------|
| **Size Limit** | 25 MB | 15 MB (50 MB with streaming) |
| **Interaction** | Limited (tap only) | Full interaction |
| **Lifecycle** | Timeline-based | Standard app lifecycle |
| **Data Access** | App Group only | Full data access |
| **UI Framework** | SwiftUI only | UIKit or SwiftUI |
| **Duration** | Persistent | Temporary |

### Migration Strategy

#### Step 1: Analyze Widget Implementation
```swift
// Existing Widget Code
struct MyWidget: Widget {
    let kind: String = "MyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("Widget description")
    }
}

// Identify components to migrate:
// 1. Data models
// 2. Business logic
// 3. UI components
// 4. Network calls
```

#### Step 2: Create App Clip Target
```swift
// AppClip.swift
import AppClipsStudio

@main
struct MyAppClip: App {
    @StateObject private var clipManager = AppClipManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
                    clipManager.handle(activity)
                }
        }
    }
}
```

#### Step 3: Migrate Data Models
```swift
// Shared Data Model (works for both)
struct SharedDataModel: Codable {
    let id: String
    let title: String
    let timestamp: Date
    
    // Widget-specific
    var widgetDisplayData: WidgetData? {
        // Transform for widget display
    }
    
    // App Clip-specific
    var appClipViewModel: AppClipViewModel {
        // Transform for app clip
    }
}
```

#### Step 4: Migrate UI Components
```swift
// Widget View
struct WidgetView: View {
    let entry: Entry
    
    var body: some View {
        VStack {
            Text(entry.title)
                .font(.headline)
            Text(entry.date, style: .time)
                .font(.caption)
        }
        .padding()
    }
}

// Migrated App Clip View
struct AppClipView: View {
    @StateObject var viewModel: AppClipViewModel
    
    var body: some View {
        VStack {
            // Enhanced UI with full interaction
            Text(viewModel.title)
                .font(.headline)
            
            Button("Take Action") {
                viewModel.performAction()
            }
            .buttonStyle(.borderedProminent)
            
            // Additional interactive elements
            DatePicker("Select Time", selection: $viewModel.selectedDate)
                .datePickerStyle(.compact)
        }
        .padding()
        .appClipCard() // AppClipsStudio modifier
    }
}
```

#### Step 5: Enhance with App Clip Features
```swift
// Add App Clip-specific features
extension AppClipView {
    func setupAppClipFeatures() {
        // Location-based features
        LocationManager.shared.requestPermission()
        
        // Payment integration
        PaymentManager.shared.setupApplePay()
        
        // Advanced analytics
        AnalyticsManager.shared.track(.appClipLaunched)
    }
}
```

### Migration Checklist

- [ ] Create App Clip target
- [ ] Configure App Clip ID and entitlements
- [ ] Migrate data models
- [ ] Convert Widget timeline to App Clip lifecycle
- [ ] Enhance UI for interactivity
- [ ] Add App Clip-specific features
- [ ] Configure associated domains
- [ ] Test invocation methods
- [ ] Optimize bundle size
- [ ] Submit for App Clip review

## From Basic App Clips to AppClipsStudio

### Benefits of Migration

1. **Enhanced Features**: NFC, QR Code, advanced analytics
2. **Better Performance**: Optimized loading and caching
3. **Simplified Development**: Reusable components and utilities
4. **Enterprise Features**: Multi-tenant support, A/B testing

### Migration Process

#### Step 1: Install AppClipsStudio
```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/AppClipsStudio/AppClipsStudio.git", from: "2.0.0")
]
```

#### Step 2: Replace Basic Implementation
```swift
// Before: Basic App Clip
class BasicAppClip {
    func handleUserActivity(_ activity: NSUserActivity) {
        guard let url = activity.webpageURL else { return }
        // Basic URL handling
    }
}

// After: AppClipsStudio
import AppClipsStudio

class EnhancedAppClip {
    let manager = AppClipManager.shared
    
    func configure() {
        manager.configure { config in
            config.enableNFC = true
            config.enableQRCode = true
            config.enableAnalytics = true
            config.cacheStrategy = .aggressive
        }
    }
    
    func handleUserActivity(_ activity: NSUserActivity) {
        manager.handle(activity) { result in
            switch result {
            case .success(let invocation):
                handleInvocation(invocation)
            case .failure(let error):
                handleError(error)
            }
        }
    }
}
```

#### Step 3: Leverage AppClipsStudio Components
```swift
// Use pre-built components
struct EnhancedView: View {
    var body: some View {
        VStack {
            // AppClipsStudio components
            AppClipHeader(
                title: "Welcome",
                subtitle: "Quick action"
            )
            
            NFCScanner { payload in
                handleNFCPayload(payload)
            }
            
            QRCodeScanner { code in
                handleQRCode(code)
            }
            
            AppClipActionButton(
                title: "Get Started",
                style: .prominent
            ) {
                performAction()
            }
        }
        .appClipContainer() // Studio modifier
    }
}
```

## Version Migration

### AppClipsStudio 1.x to 2.x

#### Breaking Changes

```swift
// 1.x - Deprecated
AppClipManager.shared.setup(configuration: config)

// 2.x - New API
AppClipManager.shared.configure { builder in
    builder.enableNFC = true
    builder.enableQRCode = true
}
```

#### Migration Script
```bash
# Run migration script
swift run appclips-migrate --from 1.0 --to 2.0

# The script will:
# 1. Update import statements
# 2. Migrate deprecated APIs
# 3. Update configuration files
# 4. Generate migration report
```

#### API Changes

| v1.x API | v2.x API | Migration Notes |
|----------|----------|-----------------|
| `AppClipManager.setup()` | `AppClipManager.configure()` | Use configuration builder |
| `handleURL(_ url:)` | `handle(_ invocation:)` | Enhanced invocation model |
| `AppClipCache` | `CacheManager` | Unified caching system |
| `AnalyticsTracker` | `AnalyticsManager` | Enhanced analytics |

### Version 2.x to 3.x (Future)

```swift
// Prepare for future migration
@available(iOS 17.0, *)
extension AppClipManager {
    func migrateToV3() async throws {
        // Automatic migration
        let migrator = V3Migrator()
        try await migrator.migrate()
    }
}
```

## Data Migration Strategies

### User Data Migration

#### From Main App to App Clip
```swift
class DataMigrator {
    static func migrateFromMainApp() async throws {
        // 1. Check for existing user data
        guard let sharedContainer = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.com.example.app"
        ) else {
            throw MigrationError.noSharedContainer
        }
        
        // 2. Read user preferences
        let userDefaults = UserDefaults(suiteName: "group.com.example.app")
        let userData = UserData(
            userId: userDefaults?.string(forKey: "userId"),
            preferences: userDefaults?.dictionary(forKey: "preferences")
        )
        
        // 3. Migrate to App Clip storage
        try await AppClipStorage.shared.store(userData)
        
        // 4. Verify migration
        let migrated = try await AppClipStorage.shared.retrieve(UserData.self)
        assert(migrated.userId == userData.userId)
    }
}
```

#### Keychain Migration
```swift
class KeychainMigrator {
    static func migrateSecureData() throws {
        // 1. Access shared keychain
        let sharedKeychain = Keychain(
            service: "com.example.app",
            accessGroup: "team.com.example"
        )
        
        // 2. Retrieve sensitive data
        let token = try sharedKeychain.get("authToken")
        let credentials = try sharedKeychain.get("credentials")
        
        // 3. Store in App Clip keychain
        let clipKeychain = AppClipKeychain.shared
        try clipKeychain.store(token, for: .authToken)
        try clipKeychain.store(credentials, for: .credentials)
    }
}
```

### Database Migration

#### Core Data Migration
```swift
class CoreDataMigrator {
    static func migrate(from oldModel: NSManagedObjectModel,
                       to newModel: NSManagedObjectModel) throws {
        // 1. Create mapping model
        let mappingModel = try NSMappingModel(
            from: [Bundle.main],
            forSourceModel: oldModel,
            destinationModel: newModel
        )
        
        // 2. Create migration manager
        let migrationManager = NSMigrationManager(
            sourceModel: oldModel,
            destinationModel: newModel
        )
        
        // 3. Perform migration
        try migrationManager.migrateStore(
            from: sourceURL,
            sourceType: NSSQLiteStoreType,
            options: nil,
            with: mappingModel,
            toDestinationURL: destinationURL,
            destinationType: NSSQLiteStoreType,
            destinationOptions: nil
        )
    }
}
```

#### Lightweight Migration
```swift
// Enable automatic lightweight migration
let container = NSPersistentContainer(name: "AppClipModel")
let description = container.persistentStoreDescriptions.first
description?.setOption(true as NSNumber, 
                       forKey: NSMigratePersistentStoresAutomaticallyOption)
description?.setOption(true as NSNumber,
                       forKey: NSInferMappingModelAutomaticallyOption)
```

## Code Migration Tools

### Automated Migration Tool

```bash
# Install migration tool
brew install appclipsstudio/tools/migrator

# Run migration analysis
appclips-migrate analyze --source ./MyApp

# Generate migration plan
appclips-migrate plan --source ./MyApp --output migration-plan.json

# Execute migration
appclips-migrate execute --plan migration-plan.json --backup ./backup

# Verify migration
appclips-migrate verify --source ./MyApp
```

### Manual Migration Helpers

```swift
// Migration utilities
class MigrationHelper {
    // Convert Widget configuration to App Clip
    static func convertWidgetConfig(_ widgetConfig: WidgetConfiguration) -> AppClipConfiguration {
        AppClipConfiguration { builder in
            builder.displayName = widgetConfig.displayName
            builder.description = widgetConfig.description
            builder.supportedFamilies = [.compact]
        }
    }
    
    // Convert Widget timeline to App Clip data
    static func convertTimeline(_ timeline: Timeline<Entry>) -> AppClipData {
        AppClipData(
            entries: timeline.entries.map { entry in
                AppClipEntry(
                    date: entry.date,
                    content: entry.content
                )
            }
        )
    }
}
```

### Migration Validation

```swift
class MigrationValidator {
    static func validate() async throws {
        // 1. Check bundle size
        let bundleSize = try getBundleSize()
        guard bundleSize < 15_000_000 else {
            throw ValidationError.bundleTooLarge(bundleSize)
        }
        
        // 2. Verify entitlements
        let entitlements = try getEntitlements()
        guard entitlements.contains("com.apple.developer.appclip") else {
            throw ValidationError.missingEntitlement
        }
        
        // 3. Test invocation
        let tester = InvocationTester()
        try await tester.testAllMethods()
        
        // 4. Validate data migration
        let dataValidator = DataMigrationValidator()
        try await dataValidator.validateMigration()
        
        print("✅ Migration validation successful")
    }
}
```

## Best Practices

### 1. Incremental Migration
- Migrate in phases rather than all at once
- Test each phase thoroughly
- Maintain backward compatibility during transition

### 2. Data Integrity
- Always backup before migration
- Verify data after each migration step
- Implement rollback mechanisms

### 3. Testing Strategy
- Test on multiple iOS versions
- Test all invocation methods
- Verify performance improvements

### 4. User Experience
- Minimize disruption during migration
- Provide clear migration status
- Handle migration failures gracefully

## Troubleshooting

### Common Migration Issues

#### Bundle Size Exceeded
```swift
// Solution: Optimize resources
ResourceOptimizer.shared.optimize { config in
    config.compressImages = true
    config.removeUnusedCode = true
    config.enableOnDemandResources = true
}
```

#### Data Loss During Migration
```swift
// Solution: Implement data verification
class DataVerifier {
    static func verifyMigration() throws {
        let original = try loadOriginalData()
        let migrated = try loadMigratedData()
        
        guard original.count == migrated.count else {
            throw MigrationError.dataCountMismatch
        }
        
        // Verify each record
        for (originalRecord, migratedRecord) in zip(original, migrated) {
            try verifyRecord(original: originalRecord, migrated: migratedRecord)
        }
    }
}
```

## Support Resources

- [AppClipDebugger.md](AppClipDebugger.md) - Debug migration issues
- [AdvancedDevelopment.md](AdvancedDevelopment.md) - Enterprise features
- [API Reference](AppClipCore.md) - Complete API documentation
- [Community Forum](https://community.appclipsstudio.com) - Get help
- [Migration Examples](https://github.com/AppClipsStudio/migration-examples) - Sample code