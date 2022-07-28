import Foundation

public struct NotificationParameters {
    let title: String
    let subtitle: String
    let state: NotificationState
    let hideDelay: TimeInterval
    
    public init(
        title: String,
        subtitle: String,
        state: NotificationState,
        hideDelay: TimeInterval = 4
    ) {
        self.title = title
        self.subtitle = subtitle
        self.state = state
        self.hideDelay = hideDelay
    }
}
