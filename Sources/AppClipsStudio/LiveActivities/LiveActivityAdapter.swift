#if os(iOS)
import Foundation
#if canImport(ActivityKit)
import ActivityKit

/// Seamlessly bridges Live Activities into App Clips.
@available(iOS 16.1, *)
public actor LiveActivityAdapter<Attributes: ActivityAttributes> {
    public init() {}
    
    public func requestActivity(attributes: Attributes, state: Attributes.ContentState) throws {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
        let content = ActivityContent(state: state, staleDate: nil)
        _ = try Activity.request(attributes: attributes, content: content)
        print("⚡ [AppClipsStudio] Live Activity spawned from App Clip.")
    }
}
#endif
#endif
