import Foundation
import NotificationCenter

extension NotificationParameters {
    static let error = NotificationParameters(
        title: "notification.error.title".localized,
        subtitle: "notification.error.description".localized,
        state: .error
    )
    
    static let checkmark = NotificationParameters(
        title: "notification.checkmark.title".localized,
        subtitle: "notification.checkmark.description".localized,
        state: .checkmark
    )
    
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
