import Foundation
import NotificationCenter

extension NotificationParameters {
    static let error = NotificationParameters(
        title: "notification.error.title".localized,
        subtitle: "notification.error.description".localized,
        state: .error
    )
    
    static func checkmark(title: String = "notification.checkmark.title".localized, description: String) -> NotificationParameters {
        NotificationParameters(
            title: title,
            subtitle: description,
            state: .checkmark
        )
    }
    
    static let warning = NotificationParameters(
        title: "notification.warning.title".localized,
        subtitle: "notification.warning.description".localized,
        state: .warning
    )
    
    static let info = NotificationParameters(
        title: "notification.info.title".localized,
        subtitle: "notification.info.description".localized,
        state: .info
    )
}
