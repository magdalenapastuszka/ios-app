import UIKit

extension UITextField {
    func placeholderColor(_ color: UIColor){
        var placeholderText = ""
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [.foregroundColor : color]
        )
    }
}
