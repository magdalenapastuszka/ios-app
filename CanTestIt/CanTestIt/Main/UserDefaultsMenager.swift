import Foundation

protocol UserDefaultsMenager {
    var wasIntroDisplayed: Bool { get }
    func storeIntroWasDisplayed()
}

final class UserDefaultsMenagerImpl: UserDefaultsMenager {
    private enum Constants {
        static let wasIntroDisplayedKey = "wasIntroDisplayed"
    }
    
    var wasIntroDisplayed: Bool {
        userDefaults.bool(forKey: Constants.wasIntroDisplayedKey)
    }
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func storeIntroWasDisplayed() {
        userDefaults.set(true, forKey: Constants.wasIntroDisplayedKey)
    }
}
