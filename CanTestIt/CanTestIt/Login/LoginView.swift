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
        static let spacing: CGFloat = 16
        static let padding: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: Constants.spacing
        ) {
            Text(viewModel.model?.title ?? "")
                .foregroundColor(Color.textColor)
                .font(.title2)
                .padding(Constants.padding)
            
            Text(viewModel.model?.emailTitle ?? "")
                .font(.callout)
                .foregroundColor(Color.textColor)
                .padding(Constants.padding)
            
            TextField("", text: $email)
                .placeHolder(
                    Text(viewModel.model?.emailPlaceholder ?? "")
                        .foregroundColor(.secondaryTextColor),
                    show: email.isEmpty
                )
                .foregroundColor(Color.textColor)
                .frame(height: .buttonHeight, alignment: .leading)
                .background(Color.textFieldBackgroundColor)
            
            Text(viewModel.model?.passwordTitle ?? "")
                .font(.callout)
                .foregroundColor(Color.textColor)
                .padding(Constants.padding)
            
            SecureField("", text: $password)
                .placeHolder(
                    Text(viewModel.model?.passwordPlaceholder ?? "")
                        .foregroundColor(.secondaryTextColor),
                    show: password.isEmpty
                )
                .foregroundColor(Color.textColor)
                .frame(height: .buttonHeight, alignment: .leading)
                .background(Color.textFieldBackgroundColor)
            
            Button(
                action: {
                    self.viewModel.handleLoginButtonTap(email: email, password: password)
                },
                label: { Text(viewModel.model?.buttonTitle ?? "")
                        .frame(
                            height: .buttonHeight,
                            alignment: .center
                        )
                        .padding(Constants.padding)
                        .foregroundColor(.buttonTitleColor)
                })
            .font(.callout)
            .background(Color.primaryColor)
            .cornerRadius(.buttonCornerRadius)
            .frame(maxHeight: .infinity, alignment: .bottom)
            
            Spacer()
            Divider()
        }
        .background(Color.backgroundColor)
        .onAppear {
            self.viewModel.loadModel()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
