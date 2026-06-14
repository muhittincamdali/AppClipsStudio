#if os(iOS)
import Foundation
import os

/// Handles Universal Links specifically optimized for App Clips.
public actor UniversalLinkRouter {
    public static let shared = UniversalLinkRouter()
    
    private init() {}
    
    /// Parses the NSUserActivity invocation payload.
    public func route(activity: NSUserActivity) -> URL? {
        guard activity.activityType == NSUserActivityTypeBrowsingWeb,
              let incomingURL = activity.webpageURL else {
            return nil
        }
        
        // Log the invocation for analytics
        print("🔗 [AppClipsStudio] Invocation URL detected: \(incomingURL.absoluteString)")
        
        return incomingURL
    }
}
#endif
