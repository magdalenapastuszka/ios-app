import UIKit

extension UITextField {
    enum IconViewAlignment {
        case left
        case right
    }

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
    
    func addIconView(alginment: IconViewAlignment, image: UIImage, leftPadding: CGFloat = 0, rightPadding: CGFloat = 0) {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.setImage(image, for: .normal)
        
        let containerView = UIView()
        containerView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leftPadding),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -rightPadding),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            button.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
        
        switch alginment {
        case .left:
            self.leftView = containerView
        case .right:
            self.rightView = containerView
        }
    }
}

