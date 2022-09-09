import Foundation

extension DateFormatter {
    static let iso8601 = formatter(with: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    static let full = formatter(with: "yyyy-MM-dd'T'HH:mm:ss:SSZ")
    static let yyyyMMddHHmm = formatter(with: "yyyy-MM-dd HH:mm")
    static let yyyyMMdd = formatter(with: "yyyy-MM-dd")
    static let HHmma = formatter(with: "HH:mm a")

    private static func formatter(with format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
