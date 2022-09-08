import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    @Published var model: LoginView.Model?
    @Published var error: String?
    @Published var isLoading: Bool = false
    
    @State var login: String?
    @State var password: String?
    
    var bbb: String = ""
    
    let showWebsite: ()  -> Void
    private var cancellable: AnyCancellable?
    private let showEventList: () -> Void
    private let userAPIManager: UserAPIManager
    
    init(
        userAPIManager: UserAPIManager,
        showWebsite: @escaping () -> Void,
        showEventList: @escaping () -> Void
    ) {
        self.userAPIManager = userAPIManager
        self.showWebsite = showWebsite
        self.showEventList = showEventList
    }
    
    func loadModel() {
        model = LoginView.Model(
            title: "login.title".localized,
            loginTitle: "login.login-textfield-title".localized,
            loginPlaceholder: "login.login-textfield-placeholder".localized,
            passwordTitle: "login.password-textfield-title".localized,
            passwordPlaceholder: "login.password-textfield-placeholder".localized,
            buttonTitle: "login.button-title".localized,
            link: makeLink()
        )
    }
    
    func handleLoginButtonTap() {
        guard let login = login,
        let password = password else {
            error = "login.error".localized
            return
        }

        error = nil
        isLoading = true
        cancellable = userAPIManager.login(login: login, password: password)
            .sink { [weak self] response in
                self?.isLoading = false
                if case .failure = response {
                    self?.error = "login.error".localized
                }
            } receiveValue: { [weak self] oAuthToken in
                self?.showEventList()
            }
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
