# Contributing to App Clips Studio

Thank you for your interest in contributing to App Clips Studio! We welcome contributions from developers of all skill levels.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Guidelines](#development-guidelines)
- [Submitting Changes](#submitting-changes)
- [Community](#community)

## Code of Conduct

This project adheres to the Contributor Covenant [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to conduct@appclipsstudio.com.

## Getting Started

### Prerequisites

- **Xcode 15.0+** with iOS 16.0+ SDK
- **Swift 5.9+**
- **Git** for version control
- **GitHub account** for pull requests

### Setting Up Development Environment

1. **Fork the repository**:
   ```bash
   # Click "Fork" on GitHub, then clone your fork
   git clone https://github.com/YOUR_USERNAME/AppClipsStudio.git
   cd AppClipsStudio
   ```

2. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/muhittincamdali/AppClipsStudio.git
   ```

3. **Install dependencies**:
   ```bash
   swift package resolve
   ```

4. **Build and test**:
   ```bash
   swift build
   swift test
   ```

## How to Contribute

### 🐛 Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates.

**Good bug reports include**:
- Clear, descriptive title
- Steps to reproduce the issue
- Expected vs. actual behavior
- Screenshots or code samples
- Environment details (Xcode version, iOS version, etc.)

### 💡 Suggesting Enhancements

Enhancement suggestions are welcome! Please provide:
- Clear description of the proposed feature
- Use cases and benefits
- Implementation considerations
- Mockups or examples (if applicable)

### 🔧 Contributing Code

#### Types of Contributions

1. **Bug fixes** - Fix existing issues
2. **New features** - Add functionality to the framework
3. **Performance improvements** - Optimize existing code
4. **Documentation** - Improve guides, comments, and examples
5. **Tests** - Add or improve test coverage
6. **Examples** - Create new example projects

#### Finding Work

- Check [Issues labeled "good first issue"](https://github.com/muhittincamdali/AppClipsStudio/labels/good%20first%20issue)
- Look for [Issues labeled "help wanted"](https://github.com/muhittincamdali/AppClipsStudio/labels/help%20wanted)
- Review the [Roadmap](https://github.com/muhittincamdali/AppClipsStudio/projects) for planned features

## Development Guidelines

### Code Style

We follow Swift's official style guide with these specific requirements:

#### Swift Code Style

```swift
// ✅ Good
public final class AppClipsStudio {
    private let configuration: AppClipsStudioConfiguration
    
    public func initialize(with config: AppClipsStudioConfiguration) async throws {
        self.configuration = config
        await setupComponents()
    }
}

// ❌ Bad
public final class AppClipsStudio{
    private let configuration:AppClipsStudioConfiguration
    
    public func initialize(with config:AppClipsStudioConfiguration) async throws{
        self.configuration=config
        await setupComponents()
    }
}
```

#### Naming Conventions

- **Types**: PascalCase (`AppClipsStudio`, `NetworkManager`)
- **Functions & Variables**: camelCase (`initialize`, `baseURL`)
- **Constants**: camelCase (`maxRetryAttempts`)
- **Enums**: PascalCase cases (`case success`, `case failure`)

#### Documentation

All public APIs must include documentation:

```swift
/// Initializes the App Clips Studio framework with the provided configuration.
/// 
/// - Parameter configuration: The configuration object containing setup parameters
/// - Throws: `AppClipError.invalidConfiguration` if configuration is invalid
/// - Returns: A configured App Clips Studio instance
public func initialize(with configuration: AppClipsStudioConfiguration) async throws {
    // Implementation
}
```

### Architecture Guidelines

#### Framework Structure

```
Sources/
├── AppClipsStudio/          # Main framework
├── AppClipCore/             # Core functionality
├── AppClipRouter/           # URL routing
├── AppClipAnalytics/        # Analytics
├── AppClipUI/               # UI components
├── AppClipNetworking/       # Networking
└── AppClipStorage/          # Storage & persistence
```

#### Design Principles

1. **Protocol-Oriented**: Use protocols for flexibility
2. **Dependency Injection**: Support for custom implementations  
3. **Async/Await**: Modern Swift concurrency
4. **Performance First**: Optimize for App Clip constraints
5. **Privacy by Design**: Minimal data collection

#### Performance Requirements

- **Launch Time**: < 100ms cold start
- **Memory Usage**: < 10MB peak usage  
- **App Size Impact**: < 5MB additional size
- **Battery Efficiency**: Minimal background processing

### Testing Guidelines

#### Test Coverage Requirements

- **Unit Tests**: > 85% code coverage
- **Integration Tests**: All major workflows
- **Performance Tests**: Key performance metrics
- **Example Tests**: All example projects must build and run

#### Writing Tests

```swift
final class AppClipsCoreTests: XCTestCase {
    
    var appClipsStudio: AppClipsStudio!
    
    override func setUp() async throws {
        try await super.setUp()
        appClipsStudio = AppClipsStudio()
    }
    
    override func tearDown() async throws {
        await appClipsStudio.cleanup()
        try await super.tearDown()
    }
    
    func testQuickSetup() async throws {
        // Given
        let url = URL(string: "https://example.com")!
        
        // When
        appClipsStudio.quickSetup(
            appClipURL: url,
            bundleIdentifier: "com.test.Clip",
            parentAppIdentifier: "com.test.App"
        )
        
        // Then
        XCTAssertEqual(appClipsStudio.configuration.coreConfig.invocationURL, url)
    }
}
```

### Documentation Guidelines

#### Types of Documentation

1. **API Documentation** - Inline code documentation
2. **Guides** - How-to guides and tutorials
3. **Examples** - Working code samples
4. **Architecture** - High-level design explanations

#### Writing Guidelines

- Use clear, concise language
- Include code examples
- Explain the "why" not just the "how"
- Keep examples up-to-date with latest API
- Use consistent terminology

## Submitting Changes

### Pull Request Process

1. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**:
   - Follow the coding guidelines
   - Add tests for new functionality
   - Update documentation as needed
   - Ensure all tests pass

3. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Add feature: brief description
   
   Detailed explanation of what was added/changed/fixed.
   
   Closes #123"
   ```

4. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create Pull Request**:
   - Use a clear, descriptive title
   - Reference related issues
   - Provide a detailed description
   - Include screenshots for UI changes

### Pull Request Template

```markdown
## Description
Brief description of changes made.

## Related Issues
Fixes #123
Relates to #456

## Type of Change
- [ ] Bug fix
- [ ] New feature  
- [ ] Performance improvement
- [ ] Documentation update
- [ ] Other (please specify)

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed
- [ ] Performance testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Changes are backwards compatible
- [ ] All tests pass
```

### Review Process

1. **Automated Checks**: CI/CD pipeline runs tests and checks
2. **Code Review**: Maintainers review the code
3. **Discussion**: Address feedback and make changes
4. **Approval**: Once approved, maintainers will merge

## Community

### Communication Channels

- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: Questions and general discussion
- **Discord**: Real-time chat with the community
- **Twitter**: [@AppClipsStudio](https://twitter.com/AppClipsStudio) for announcements

### Getting Help

- **Documentation**: Check the [docs](Documentation/) first
- **Examples**: Look at working examples in the [Examples](Examples/) directory
- **Stack Overflow**: Use the `app-clips-studio` tag
- **GitHub Discussions**: Ask questions in the community

### Recognition

Contributors are recognized in several ways:

- **Contributor list**: Listed in project README
- **Release notes**: Credited for contributions
- **Special roles**: Active contributors may become maintainers
- **Swag**: Occasional contributor packages

## Development Workflow

### Branching Strategy

- **main**: Stable release branch
- **develop**: Integration branch for features
- **feature/***: Individual feature branches
- **hotfix/***: Critical bug fixes
- **release/***: Release preparation branches

### Release Process

1. **Feature freeze** on develop branch
2. **Create release branch** from develop
3. **Bug fixes and testing** on release branch
4. **Merge to main** and tag release
5. **Deploy to package managers**
6. **Update documentation** and examples

## License

By contributing to App Clips Studio, you agree that your contributions will be licensed under the [MIT License](LICENSE).

## Questions?

Don't hesitate to reach out:

- **Email**: contribute@appclipsstudio.com
- **GitHub**: Open an issue or discussion
- **Discord**: Join our community server

---

**Thank you for contributing to App Clips Studio!** 🎉

Your contributions help make App Clips development faster and more enjoyable for everyone.