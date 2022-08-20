import Foundation
import UIKit
import UIMagicDropDown

final class EventFormView: BaseView {
    struct Model {
        let viewTitle: String
        let eventFieldTitle: String
        let eventFieldPlaceholder: String
        let eventFieldIcon: UIImage
        let categoryFieldTitle: String
        let categoryFieldPlaceholder: String
        let categoryFieldIcon: UIImage
        let startDateFieldTitle: String
        let startDateFieldPlaceholder: String
        let startDateIcon: UIImage
        let endDateFieldTitle: String
        let endDateFieldPlaceholder: String
        let endDateIcon: UIImage
        let priceFieldTitle: String
        let priceFieldPlaceholder: String
        let priceFieldIcon: UIImage
        let premiumSwitchTitle: String
        let saveButtonTitle: String
        let cancelButtonTitle: String
        let deleteButtonTitle: String
        let isDeleteButtonHidden: Bool
    }
    
    private enum Constants {
        static let spacing: CGFloat = 32
        static let smallSpacing: CGFloat = 8
        static let dateFieldCenterSpacing: CGFloat = 10
        static let switchWidth: CGFloat = 51
    }
    
    private let scrollView = UIScrollView()
    
    private let formView = UIStackView()
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel().then {
        $0.textColor = .primaryColor
        $0.font = .font(.callout)
    }
    
    private let eventTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let eventTtitleTextField = TextFieldWithPadding().then {
        $0.textColor = .textColor
        $0.placeholderColor(.placeholderColor)
        $0.layer.cornerRadius = .defaultCornerRadius
        $0.backgroundColor = .textFieldBackgroundColor
        $0.leftViewMode = .always
    }
    
    private let categoryTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let categoryDropdownField = UIMagicDropdown(
        theme: MagicDropDownConfig.category,
        items: []
    )
    
    private let startDateTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let startDateTextField = DateTextField().then {
        $0.textColor = .textColor
        $0.placeholderColor(.placeholderColor)
        $0.layer.cornerRadius = .defaultCornerRadius
        $0.backgroundColor = .textFieldBackgroundColor
        $0.leftViewMode = .always
    }
    
    private let endDateTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let endDateTextField = DateTextField().then {
        $0.textColor = .textColor
        $0.placeholderColor(.placeholderColor)
        $0.layer.cornerRadius = .defaultCornerRadius
        $0.backgroundColor = .textFieldBackgroundColor
        $0.leftViewMode = .always
    }
    
    private let priceTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private let priceTextField = TextFieldWithPadding().then {
        $0.textColor = .textColor
        $0.placeholderColor(.placeholderColor)
        $0.layer.cornerRadius = .defaultCornerRadius
        $0.backgroundColor = .textFieldBackgroundColor
        $0.keyboardType = .numberPad
        $0.leftViewMode = .always
    }
    
    private let premiumEventSwitch = UISwitch().then {
        $0.onTintColor = .primaryColor
    }
    
    private let premiumEventTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(.callout)
    }
    
    private let errorLabel = UILabel().then {
        $0.textColor = .errorColor
        $0.font = .font(.subheadline)
    }
    
    private let buttonsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = .defaultPadding
    }

    private let saveButton = UIButton().then {
        $0.setTitleColor(.buttonTitleColor, for: .normal)
        $0.backgroundColor = .primaryColor
        $0.layer.cornerRadius = .defaultCornerRadius
    }
    
    private let cancelButton = UIButton().then {
        $0.setTitleColor(.cancelColor, for: .normal)
        $0.layer.borderWidth = .defaultBorderWidth
        $0.layer.cornerRadius = .defaultCornerRadius
        $0.layer.borderColor = UIColor.cancelColor.cgColor
    }
    
    private let deleteButton = UIButton().then {
        $0.setTitleColor(.placeholderColor, for: .normal)
    }
    
    private let handleDidTapSaveButton: () -> Void
    private let handleDidTapCancelButton: () -> Void
    private let handleDidTapDeleteButton: () -> Void
    private let handleDidTapImageView: () -> Void
    
    init(
        model: Model,
        handleDidTapSaveButton: @escaping () -> Void,
        handleDidTapCancelButton: @escaping () -> Void,
        handleDidTapDeleteButton: @escaping () -> Void,
        handleDidTapImageView: @escaping () -> Void

    ) {
        self.handleDidTapSaveButton = handleDidTapSaveButton
        self.handleDidTapCancelButton = handleDidTapCancelButton
        self.handleDidTapDeleteButton = handleDidTapDeleteButton
        self.handleDidTapImageView = handleDidTapImageView
        super.init()
        setUpViewHierarchy()
        setUpConstraints()
        fill(with: model)
        bindAction()
    }
    
    func showError(message: String?) {
        errorLabel.text = message
    }
    
    func fill(dropDownData: [UIMagicDropdownData]) {
        categoryDropdownField.items = dropDownData
    }
    
    func fill(with event: Event) {
        eventTtitleTextField.text = event.name
        if let startDate = event.startDate {
            startDateTextField.text = DateFormatter.yyyyMMddHHmm.string(from: startDate)
        }
        if let endDate = event.endDate {
            endDateTextField.text = DateFormatter.yyyyMMddHHmm.string(from: endDate)
        }
        priceTextField.text = "\(event.price)"
        premiumEventSwitch.isOn = event.isPremium
        categoryDropdownField.itemSelected = categoryDropdownField.items?.firstIndex(where: { $0.label == event.category })
    }
    
    private func fill(with model: Model) {
        titleLabel.text = model.viewTitle
        eventTitleLabel.text = model.eventFieldTitle
        eventTtitleTextField.placeholder = model.eventFieldPlaceholder
        eventTtitleTextField.placeholderColor(.placeholderColor)
        eventTtitleTextField.addIconView(
            alginment: .left,
            image: model.eventFieldIcon,
            leftPadding: .defaultPadding
        )
        
        categoryTitleLabel.text = model.categoryFieldTitle
        categoryDropdownField.hintMessage = model.categoryFieldPlaceholder
        
        startDateTitleLabel.text = model.startDateFieldTitle
        startDateTextField.placeholder = model.startDateFieldPlaceholder
        startDateTextField.placeholderColor(.placeholderColor)
        startDateTextField.addIconView(
            alginment: .left,
            image: model.startDateIcon,
            leftPadding: .defaultPadding
        )
        
        endDateTitleLabel.text = model.endDateFieldTitle
        endDateTextField.placeholder = model.endDateFieldPlaceholder
        endDateTextField.placeholderColor(.placeholderColor)
        endDateTextField.addIconView(
            alginment: .left,
            image: model.endDateIcon,
            leftPadding: .defaultPadding
        )
        
        priceTitleLabel.text = model.priceFieldTitle
        priceTextField.placeholder = model.priceFieldPlaceholder
        priceTextField.placeholderColor(.placeholderColor)
        priceTextField.addIconView(
            alginment: .left,
            image: model.priceFieldIcon,
            leftPadding: .defaultPadding
        )
        
        premiumEventTitleLabel.text = model.premiumSwitchTitle
        
        saveButton.setTitle(model.saveButtonTitle, for: .normal)
        cancelButton.setTitle(model.cancelButtonTitle, for: .normal)
        deleteButton.setTitle(model.deleteButtonTitle, for: .normal)
        
        if !model.isDeleteButtonHidden {
            buttonsStackView.addArrangedSubview(deleteButton)
        }
    }
    
    private func setUpViewHierarchy() {
        containerView.addSubview(scrollView)
        scrollView.addSubview(formView)
        
        formView.addSubviews([
            imageView,
            titleLabel,
            eventTitleLabel,
            eventTtitleTextField,
            categoryTitleLabel,
            categoryDropdownField,
            startDateTitleLabel,
            startDateTextField,
            endDateTitleLabel,
            endDateTextField,
            priceTitleLabel,
            priceTextField,
            premiumEventSwitch,
            premiumEventTitleLabel,
            errorLabel,
            buttonsStackView
        ])
        
        buttonsStackView.addArangedSubviews([
            saveButton,
            cancelButton
        ])
    }
    
    private func setUpConstraints() {
        setUpScrollViewConstraints()
        setUpContainerStackViewConstraints()
        setUpImageViewConstraints()
        setUpTitleLabelConstraints()
        setUpEventTitleLabelConstraints()
        setUpEventTtitleTextFieldConstraints()
        setUpCategoryTitleLabelConstraints()
        setUpCategoryDropdownFieldConstraints()
        setUpStartDateTitleLabelConstraints()
        setUpStartDateButtonConstraints()
        setUpEndDateTitleLabelConstraints()
        setUpEndDateButtonConstraints()
        setUpPriceTitleLabelConstraints()
        setUpPriceTextFieldConstraints()
        setUpPremiumEventSwitchConstraints()
        setUpPremiumEventTitleLabelConstraints()
        setUpErrorLabelConstraints()
        setUpButtonsStackViewConstraints()
        setUpButtonsHeightConstraints()
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
        formView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            formView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            formView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            formView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setUpImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: formView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: formView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: formView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.spacing)
        ])
    }
    
    private func setUpEventTitleLabelConstraints() {
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventTitleLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            eventTitleLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            eventTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .defaultPadding)
        ])
    }
    
    private func setUpEventTtitleTextFieldConstraints() {
        eventTtitleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventTtitleTextField.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            eventTtitleTextField.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            eventTtitleTextField.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: Constants.smallSpacing),
            eventTtitleTextField.heightAnchor.constraint(equalToConstant: .defaultControlHeight)
        ])
    }
    
    private func setUpCategoryTitleLabelConstraints() {
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryTitleLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            categoryTitleLabel.topAnchor.constraint(equalTo: eventTtitleTextField.bottomAnchor, constant: .defaultPadding)
        ])
    }
    
    private func setUpCategoryDropdownFieldConstraints() {
        categoryDropdownField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryDropdownField.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            categoryDropdownField.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            categoryDropdownField.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: Constants.smallSpacing),
//            categoryDropdownField.heightAnchor.constraint(equalToConstant: .defaultControlHeight)
        ])
    }
    
    private func setUpStartDateTitleLabelConstraints() {
        startDateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateTitleLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            startDateTitleLabel.trailingAnchor.constraint(equalTo: formView.centerXAnchor, constant:
                                                            -Constants.dateFieldCenterSpacing),
            startDateTitleLabel.topAnchor.constraint(equalTo: categoryDropdownField.bottomAnchor, constant: .defaultPadding)
        ])
    }
    
    private func setUpStartDateButtonConstraints() {
        startDateTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateTextField.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            startDateTextField.trailingAnchor.constraint(equalTo: formView.centerXAnchor, constant:
                                                            -Constants.dateFieldCenterSpacing),
            startDateTextField.topAnchor.constraint(equalTo: startDateTitleLabel.bottomAnchor, constant: Constants.smallSpacing),
            startDateTextField.heightAnchor.constraint(equalToConstant: .defaultControlHeight)
        ])
    }
    
    private func setUpEndDateTitleLabelConstraints() {
        endDateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            endDateTitleLabel.leadingAnchor.constraint(equalTo: formView.centerXAnchor, constant: Constants.dateFieldCenterSpacing),
            endDateTitleLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant:
                    -.defaultPadding),
            endDateTitleLabel.topAnchor.constraint(equalTo: categoryDropdownField.bottomAnchor, constant: .defaultPadding)
        ])
    }
    
    private func setUpEndDateButtonConstraints() {
        endDateTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            endDateTextField.leadingAnchor.constraint(equalTo: formView.centerXAnchor, constant: Constants.dateFieldCenterSpacing),
            endDateTextField.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant:
                                                        -.defaultPadding),
            endDateTextField.topAnchor.constraint(equalTo: endDateTitleLabel.bottomAnchor, constant: Constants.smallSpacing),
            endDateTextField.heightAnchor.constraint(equalToConstant: .defaultControlHeight)
        ])
    }
    
    private func setUpPriceTitleLabelConstraints() {
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceTitleLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            priceTitleLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            priceTitleLabel.topAnchor.constraint(equalTo: startDateTextField.bottomAnchor, constant: .defaultPadding)
        ])
    }
    
    private func setUpPriceTextFieldConstraints() {
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceTextField.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            priceTextField.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            priceTextField.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: Constants.smallSpacing),
            priceTextField.heightAnchor.constraint(equalToConstant: .defaultControlHeight)
        ])
    }
    
    private func setUpPremiumEventSwitchConstraints() {
        premiumEventSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            premiumEventSwitch.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            premiumEventSwitch.trailingAnchor.constraint(equalTo: premiumEventTitleLabel.leadingAnchor, constant: -.defaultPadding),
            premiumEventSwitch.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: Constants.smallSpacing),
            premiumEventSwitch.widthAnchor.constraint(equalToConstant: Constants.switchWidth)
        ])
    }
    
    private func setUpPremiumEventTitleLabelConstraints() {
        premiumEventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            premiumEventTitleLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            premiumEventTitleLabel.centerYAnchor.constraint(equalTo: premiumEventSwitch.centerYAnchor)
        ])
    }
    
    private func setUpErrorLabelConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            errorLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            errorLabel.topAnchor.constraint(equalTo: premiumEventSwitch.bottomAnchor, constant: .defaultPadding),
        ])
    }
    
    private func setUpButtonsStackViewConstraints() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            buttonsStackView.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            buttonsStackView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: .defaultPadding),
            buttonsStackView.bottomAnchor.constraint(equalTo: formView.bottomAnchor, constant: -.defaultPadding)
        ])
    }
    
    private func setUpButtonsHeightConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: .defaultControlHeight),
            cancelButton.heightAnchor.constraint(equalToConstant: .defaultControlHeight),
            deleteButton.heightAnchor.constraint(equalToConstant: .defaultControlHeight),
        ])
    }
    
    private func bindAction() {
        categoryDropdownField.dropDownDelegate = self
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView)))
    }
    
    @objc private func didTapSaveButton() {
        handleDidTapSaveButton()
    }
    
    @objc private func didTapCancelButton() {
        handleDidTapCancelButton()
    }
    
    @objc private func didTapDeleteButton() {
        handleDidTapDeleteButton()
    }
    
    @objc private func didTapImageView() {
        handleDidTapImageView()
    }
}

extension EventFormView: UIMagicDropDownDelegate {
    func dropDownSelected(_ item: UIMagicDropdownData, _ sender: UIMagicDropdown) {
        categoryDropdownField.theme?.colors?.hintTextColor = categoryDropdownField.itemSelected == nil
        ? .placeholderColor
        : .textColor
    }
    
    func dropdownExpanded(_ sender: UIMagicDropdown) {
        formView.bringSubviewToFront(sender)
    }
}
