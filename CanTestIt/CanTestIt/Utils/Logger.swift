import os.log
import Foundation

public struct Logger {
    private let subsystem = Bundle.main.bundleIdentifier!
    private let category: Category
    private let privacy: Privacy
    private let args: [String]
    private let type: OSLogType

    private var message: StaticString {
        privacy == .public ? "%{public}@" : "%{private}@"
    }

    public static func network(type: OSLogType = .default, privacy: Privacy = .public, _ args: String...) {
        Logger(category: .network, privacy: privacy, args: args, type: type)
            .log()
    }

    public static func other(type: OSLogType = .info, privacy: Privacy = .public, _ args: String...) {
        Logger(category: .other, privacy: privacy, args: args, type: type)
            .log()
    }

    public static func error(type: OSLogType = .error, privacy: Privacy = .public, _ args: String...) {
        Logger(category: .error, privacy: privacy, args: args, type: type)
            .log()
    }

    public static func custom(type: OSLogType = .default, privacy: Privacy = .public, _ args: String...) {
        Logger(category: .custom, privacy: privacy, args: args, type: type)
            .log()
    }

    private func log() {
        #if LOGGER || DEBUG
            args.forEach { arg in
                os_log(
                    message,
                    log: .init(subsystem: subsystem, category: category.category),
                    type: type,
                    arg
                )
            }
        #endif
    }
}

public extension Logger {
    enum Privacy {
        case `public`, `private`
    }

    enum Category: String {
        case network, other, error, custom

        internal var category: String {
            rawValue.prefix(1).capitalized + rawValue.dropFirst()
        }
    }
}
