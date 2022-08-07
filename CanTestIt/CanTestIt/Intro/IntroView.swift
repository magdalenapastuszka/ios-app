import SwiftUI

struct IntroView: View {
    struct Model {
        let image: UIImage
        let title: String
        let subtitle: String
        let buttonTitle: String
    }
    
    private enum Constants {
        static let imagePadding = EdgeInsets(
            top: 60,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        static let buttonPadding = EdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        static let buttonSpacing: CGFloat = 24
        static let socialButtonSize: CGFloat = 57
        static let socialButtonTopPadding: CGFloat = 54
        static let spacing: CGFloat = 16
        static let imageSize = CGSize(width: 205, height: 30)
    }
    
    @ObservedObject private var viewModel: IntroViewModel
    
    init(viewModel: IntroViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
            Image(uiImage: viewModel.model?.image ?? UIImage())
                .resizable()
                .frame(
                    width: Constants.imageSize.width,
                    height: Constants.imageSize.height,
                    alignment: .center
                )
                .padding(Constants.imagePadding)
            
            Spacer()
                .frame(alignment: .center)
            
            Text(viewModel.model?.title ?? "")
                .foregroundColor(.textColor)
                .font(.title2)
            
            Text(viewModel.model?.subtitle ?? "")
                .foregroundColor(.secondaryTextColor)
                .font(.body)
                .multilineTextAlignment(.center)
                .alignmentGuide(VerticalAlignment.center) {
                    $0[VerticalAlignment.center]
                }
            
            Spacer(minLength: Constants.socialButtonTopPadding)
            
            HStack(
                alignment: .center,
                spacing: Constants.buttonSpacing
            ) {
                Button(
                    action: viewModel.showFacebook,
                    label: {
                        Image(uiImage: .facebook)
                    }
                )
                .frame(
                    width: Constants.socialButtonSize,
                    height: Constants.socialButtonSize,
                    alignment: .center
                )
                
                Button(
                    action: viewModel.showLinkedIn,
                    label: {
                        Image(uiImage: .linkedIn)
                    })
                .frame(
                    width: Constants.socialButtonSize,
                    height: Constants.socialButtonSize,
                    alignment: .center
                )
                
                Button(
                    action: viewModel.showInstagram,
                    label: {
                        Image(uiImage: .instagram)
                    })
                .frame(
                    width: Constants.socialButtonSize,
                    height: Constants.socialButtonSize,
                    alignment: .center
                )
            }
            
            Button(
                action: viewModel.showLoginScreen,
                label: { Text(viewModel.model?.buttonTitle ?? "")
                        .frame(
                            height: .defaultControlHeight,
                            alignment: .center
                        )
                        .padding(Constants.buttonPadding)
                        .foregroundColor(.buttonTitleColor)
                })
            .font(.callout)
            .background(Color.primaryColor)
            .cornerRadius(.defaultCornerRadius)
            .frame(maxHeight: .infinity, alignment: .bottom)
            
            Divider()
            Spacer()
        }
        .background(Color.backgroundColor)
        .onAppear {
            self.viewModel.loadModel()
            self.viewModel.viewDidLoad()
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(viewModel: IntroViewModel(
            userDefaultManager: UserDefaultsMenagerImpl(),
            showLoginScreen: {},
            showFacebook: {},
            showInstagram: {},
            showLinkedIn: {}
        ))
    }
}
