import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    var floatValue: Float? {
        Float(self)
    }
}
