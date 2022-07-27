
import UIKit

final class NotificationDefaultView: UIView {
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var bubblesImageView: UIImageView!
    
    private struct Constants {
        static let minWidth: CGFloat = 210
        static let minHeight: CGFloat = 60
        static let outerMargin: CGFloat = 16
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 26
    }
        
    class func instanceFromNib() -> NotificationDefaultView {
        return UINib(nibName: "NotificationDefaultView", bundle: Bundle(for: NotificationDefaultView.self) ).instantiate(withOwner: nil, options: nil)[0] as! NotificationDefaultView
    }
    
    var closeAction: (() -> Void)?
    
    func configure(with parameters: NotificationParameters) {
        backgroundColor = .clear
        topContainerView.backgroundColor = .clear
        containerView.backgroundColor = .black
        containerView.layer.borderColor = parameters.state.borderColor.cgColor
        containerView.layer.borderWidth = Constants.borderWidth
        containerView.layer.cornerRadius = Constants.cornerRadius
        
        titleLabel.textColor = .white
        titleLabel.text = parameters.title

        subtitleLabel.textColor = .white
        subtitleLabel.text = parameters.subtitle
        
        imageView.image = parameters.state.icon
        bubblesImageView.image = parameters.state.bubble
        bubblesImageView.clipsToBounds = true
        bubblesImageView.layer.cornerRadius = Constants.cornerRadius
        bubblesImageView.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        setUpDefaultViewConstraints()
    }
    
    private func setUpDefaultViewConstraints() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        window.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: window.frame.width - 2 * Constants.outerMargin),
            centerXAnchor.constraint(equalTo: window.centerXAnchor),
            bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.outerMargin)
        ])
    }
    
    @objc private func didTapCloseButton() {
        closeAction?()
    }
}
