import Foundation
import SwiftUI

final class IntroViewModel: ObservableObject {
    @Published var model: IntroView.Model?
    let showLoginScreen: () -> Void
    let showFacebook: () -> Void
    let showInstagram: () -> Void
    let showLinkedIn: () -> Void
    
    private let userDefaultManager: UserDefaultsMenager
    
    init(
        userDefaultManager: UserDefaultsMenager,
        showLoginScreen: @escaping () -> Void,
        showFacebook: @escaping () -> Void,
        showInstagram: @escaping () -> Void,
        showLinkedIn: @escaping () -> Void
    ) {
        self.userDefaultManager = userDefaultManager
        self.showLoginScreen = showLoginScreen
        self.showFacebook = showFacebook
        self.showInstagram = showInstagram
        self.showLinkedIn = showLinkedIn
    }
    
    func loadModel() {
        model = IntroView.Model(
            image: .logo,
            title: "intro.title".localized,
            subtitle: "intro.subtitle".localized,
            buttonTitle: "intro.button-title".localized
        )
    }
    
    func viewDidLoad() {
        userDefaultManager.storeIntroWasDisplayed()
    }
}
