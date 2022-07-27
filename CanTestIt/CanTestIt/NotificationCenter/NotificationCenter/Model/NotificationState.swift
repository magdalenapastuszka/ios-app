import Foundation
import UIKit

public enum NotificationState {
    case checkmark
    case error
    case warning
    case info
}

extension NotificationState {
    var icon: UIImage {
        switch self {
        case .checkmark:
            return UIImage(
                named: "checkmark",
                in: Bundle(for: NotificationDefaultView.self),
                compatibleWith: nil
            )!
        case .error:
            return UIImage(
                named: "error",
                in: Bundle(for: NotificationDefaultView.self),
                compatibleWith: nil
            )!
        case .warning:
            return UIImage(
                named: "warning",
                in: Bundle(for: NotificationDefaultView.self),
                compatibleWith: nil
            )!
        case .info:
            return UIImage(
                named: "info",
                in: Bundle(for: NotificationDefaultView.self),
                compatibleWith: nil
            )!
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .checkmark:
            return UIColor(hex: "#2D6A4F")
        case .error:
            return UIColor(hex: "#FF6363")
        case .warning:
            return UIColor(hex: "#F88F01")
        case .info:
            return UIColor(hex: "#0070AC")
        }
    }
    
    var bubble: UIImage {
        switch self {
        case .checkmark:
            return UIImage(
                named: "greenBubbles",
                in: Bundle(for: NotificationDefaultView.self),
                compatibleWith: nil
            )!
        case .error:
            return UIImage(
                named: "redBubbles",
                in: Bundle(for: NotificationDefaultView.self),
                compatibleWith: nil
            )!
        case .warning:
            return UIImage(
                named: "yellowBubbles",
                in: Bundle(for: NotificationDefaultView.self),
                compatibleWith: nil
            )!
        case .info:
            return UIImage(
                named: "blueBubbles",
                in: Bundle(for: NotificationDefaultView.self),
                compatibleWith: nil
            )!
        }
    }
}
