import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var model: LoginView.Model?
    
    func loadModel() {
        model = LoginView.Model(
            title: "login.title".localized,
            emailTitle: "login.email-textfield-title".localized,
            emailPlaceholder: "login.email-textfield-placeholder".localized,
            passwordTitle: "login.password-textfield-title".localized,
            passwordPlaceholder: "login.password-textfield-placeholder".localized,
            buttonTitle: "login.button-title".localized,
            link: NSAttributedString(string: "login.link-text".localized)
        )
    }
    
    func handleLoginButtonTap(email: String, password: String) {
        
    }
}
