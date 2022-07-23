import SwiftUI
import UIKit

protocol InputFieldDelegate {
    func didBeginEditing(textField: UITextField)
    func didEndEditing(textField: UITextField)
    func didLeftItemtapped(_ button: UIButton)
}
extension InputFieldDelegate {
    func didBeginEditing(textField: UITextField) {}
    func didEndEditing(textField: UITextField) {}
    func didLeftItemtapped(_ button: UIButton) {}
}

struct InputField: UIViewRepresentable {
    var placeholder: String?
    var rightItem: UIImage?
    var leftItem: UIImage?
    var isSecuredEntry = false
    var handleLeftTap: (() -> ()) = {}
    var delegate: InputFieldDelegate?
    @Binding var text: String?
    private let textField = TextFieldWithPadding()
    private let rightView = UIButton()
    
    func makeUIView(context: UIViewRepresentableContext<InputField>) -> UITextField {
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecuredEntry
        textField.text = text
        textField.textColor = .textColor
        textField.placeholderColor(.placeholderColor)
        
        if let rightimg = rightItem {
            rightView.setImage(rightimg, for: .normal)
            rightView.imageEdgeInsets = UIEdgeInsets(top: 0, left: -CGFloat.defaultPadding, bottom: 0, right: 0)
            rightView.tintColor = .placeholderColor
            rightView.addTarget(context.coordinator, action: #selector(context.coordinator.handleLeftTap(_:)), for: .touchUpInside)
            textField.rightView = rightView
            textField.rightViewMode = .always
        }
        
        if let leftImg = leftItem {
           let imgView = UIImageView()
           imgView.image = leftImg
           textField.leftView = imgView
           textField.leftViewMode = .always
        }
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<InputField>) {
        DispatchQueue.main.async {
            self.text = uiView.text
        }
    }
    
    func makeCoordinator() -> InputField.Coordinator {
        Coordinator(self, isPassword: self.isSecuredEntry)
    }

    final class Coordinator: NSObject , UITextFieldDelegate {
        var parent: InputField
        private var isPasswordField: Bool
        
        init(_ parent: InputField , isPassword: Bool) {
            self.parent = parent
            self.isPasswordField = isPassword
        }
        
        @objc func handleLeftTap(_ button : UIButton) {
            if isPasswordField {
                self.parent.textField.isSecureTextEntry = !self.parent.textField.isSecureTextEntry
                self.parent.rightView.setImage(
                    parent.textField.isSecureTextEntry
                    ? UIImage(systemName: "eye")
                    : UIImage(systemName: "eye.slash"),
                    for: .normal
                )
            } else {
                self.parent.handleLeftTap()
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.delegate?.didEndEditing(textField: textField)
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.parent.delegate?.didBeginEditing(textField: textField)
        }
    }
}
