import SwiftUI

struct LoginView: View {
    struct Model {
        let title: String
        let emailTitle: String
        let emailPlaceholder: String
        let passwordTitle: String
        let passwordPlaceholder: String
        let buttonTitle: String
        let link: NSAttributedString
    }
    
    private let viewModel: LoginViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    private enum Constants {
        static let topPadding: CGFloat = 55
        static let smallSpacing: CGFloat = 8
        static let spacing: CGFloat = 16
        static let bigSpacing: CGFloat = 44
        static let padding: CGFloat = 24
        static let cornerRadius: CGFloat = 4
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        viewModel.loadModel()
    }
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text(viewModel.model?.title ?? "")
                .foregroundColor(Color.textColor)
                .font(.title2)
                .padding([.top], Constants.topPadding)
                        
            Text(viewModel.model?.emailTitle ?? "")
                .font(.callout)
                .foregroundColor(Color.textColor)
                .padding([.top], Constants.topPadding)
            
            TextField("", text: $email)
                .placeHolder(
                    Text(viewModel.model?.emailPlaceholder ?? "")
                        .foregroundColor(.secondaryTextColor),
                    show: email.isEmpty
                )
                .foregroundColor(Color.textColor)
                .frame(height: .buttonHeight, alignment: .leading)
                .background(Color.textFieldBackgroundColor)
                .background(
                    RoundedRectangle(
                        cornerRadius: Constants.cornerRadius,
                        style: .continuous
                    )
                    .stroke(
                        viewModel.error != nil ? Color.errorColor : Color.clear, lineWidth: 1
                    )
                )
            
            Text(viewModel.model?.passwordTitle ?? "")
                .font(.callout)
                .foregroundColor(Color.textColor)
                .padding([.top], Constants.spacing)
            
            SecureInputView("", text: $password)
                .placeHolder(
                    Text(viewModel.model?.passwordPlaceholder ?? "")
                        .foregroundColor(.secondaryTextColor),
                    show: password.isEmpty
                )
                .foregroundColor(Color.textColor)
                .frame(height: .buttonHeight, alignment: .leading)
                .background(Color.textFieldBackgroundColor)
                .background(
                    RoundedRectangle(
                        cornerRadius: Constants.cornerRadius,
                        style: .continuous
                    )
                    .stroke(
                        viewModel.error != nil ? Color.errorColor : Color.clear, lineWidth: 1
                    )
                )
            
            Button(
                action: {
                    self.viewModel.handleLoginButtonTap(email: email, password: password)
                },
                label: { Text(viewModel.model?.buttonTitle ?? "")
                        .frame(
                            minWidth: .zero,
                            maxWidth: .infinity,
                            maxHeight: .buttonHeight,
                            alignment: .center
                        )
                        .foregroundColor(.buttonTitleColor)
                })
            .font(.callout)
            .background(Color.primaryColor)
            .cornerRadius(.buttonCornerRadius)
            .padding([.top], Constants.bigSpacing)
            Text(viewModel.error ?? "")
                .font(.body)
                .foregroundColor(Color.errorColor)
            Spacer()
            Divider()
            
            AttributedText(viewModel.model?.link ?? NSAttributedString(string: ""))
                .gesture(TapGesture().onEnded(viewModel.showWebsite))
        }
        .padding([.leading, .trailing], Constants.padding)
        .background(Color.backgroundColor)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(showWebsite: {}))
    }
}
