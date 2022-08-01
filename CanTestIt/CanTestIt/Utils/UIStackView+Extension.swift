import UIKit

extension UIStackView {
    func addArangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview)
    }
}
