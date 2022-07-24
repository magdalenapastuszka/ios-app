import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var model: LoginView.Model?
    @Published var error: String? = "fsdf"
    
    let showWebsite: ()  -> Void
    private let showEventList: () -> Void
    
    init(
        showWebsite: @escaping () -> Void,
        showEventList: @escaping () -> Void
    ) {
        self.showWebsite = showWebsite
        self.showEventList = showEventList
    }
    
    func loadModel() {
        model = LoginView.Model(
            title: "login.title".localized,
            emailTitle: "login.email-textfield-title".localized,
            emailPlaceholder: "login.email-textfield-placeholder".localized,
            passwordTitle: "login.password-textfield-title".localized,
            passwordPlaceholder: "login.password-textfield-placeholder".localized,
            buttonTitle: "login.button-title".localized,
            link: makeLink()
        )
    }
    
    func handleLoginButtonTap(email: String, password: String) {
        showEventList()
    }
    
    private func makeLink() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(
            string: "login.link-text".localized,
            attributes: [
                .font: UIFont.font(.subheadline),
                .foregroundColor: UIColor.textColor,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        let range = attributedString
            .mutableString
            .range(
                of: "login.link-replace-text".localized,
                options: .caseInsensitive
            )
        
        attributedString.addAttributes([
            .font: UIFont.font(size: 16, weight: .semibold),
            .foregroundColor: UIColor.primaryColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.primaryColor,
        ], range: range)
        
        return attributedString
    }
}
