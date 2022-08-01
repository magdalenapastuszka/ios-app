import Foundation
import UIKit
import UIMagicDropDown

final class EventFormView: BaseView {
    
    private let scrollView = UIScrollView()
    
    private let containerStackView = UIStackView()
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel().then {
        $0.textColor = .primaryColor
        $0.font = .font(.callout)
    }
    
    private let eventTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let eventTtitleTextField = UITextField().then {
        $0.textColor = .textColor
        $0.placeholderColor(.placeholderColor)
    }
    
    private let categoryTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let categoryDropdownField = UIMagicDropdown(items: [])
    
    private let startDateTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let startDateButton = UIButton()
    
    private let endDateTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let endDateButton = UIButton()
    
    private let priceTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let priceTextField = UITextField().then {
        $0.textColor = .textColor
        $0.placeholderColor(.placeholderColor)
    }
    
    private let premiumEventSwitch = UISwitch()
    
    private let premiumEventTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(.callout)
    }

    private let saveButton = UIButton().then {
        $0.setTitleColor(.buttonTitleColor, for: .normal)
        $0.backgroundColor = .primaryColor
    }
    
    private let cancelButton = UIButton().then {
        $0.setTitleColor(.buttonTitleColor, for: .normal)
        $0.backgroundColor = .primaryColor
    }
    
    private let deleteButton = UIButton().then {
        $0.setTitleColor(.buttonTitleColor, for: .normal)
        $0.backgroundColor = .primaryColor
    }
    
    private func setUpViewHierarchy() {
        containerView.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        
        containerStackView.addArangedSubviews([
            imageView,
            titleLabel
        ])
    }
    
    private func setUpConstraints() {
        setUpScrollViewConstraints()
        setUpContainerStackViewConstraints()
    }
    
    private func setUpScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
    
    private func setUpContainerStackViewConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: .defaultPadding),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -.defaultPadding),
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .defaultPadding),
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.defaultPadding)
        ])
    }
}
