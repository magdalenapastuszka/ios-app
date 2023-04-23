import Foundation
import UIKit
import UIMagicDropDown

struct EventFormData {
    let name: String?
    let category: Int?
    let price: String?
    let dateFrom: Date?
    let dateTo: Date?
    let isPremium: Bool
}

final class EventFormView: BaseView {
    struct Model {
        let emptyPicture: UIImage
        let emptyPictureTitle: String
        let viewTitle: String
        let eventFieldTitle: String
        let eventFieldPlaceholder: String
        let eventFieldIcon: UIImage
        let categoryFieldTitle: String
        let categoryFieldPlaceholder: String
        let categoryFieldData: [UIMagicDropdownData]
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
        let event: Event?
    }
    
    private enum Constants {
        static let spacing: CGFloat = 32
        static let smallSpacing: CGFloat = 8
        static let dateFieldCenterSpacing: CGFloat = 10
        static let switchWidth: CGFloat = 51
    }
    
    private let scrollView = UIScrollView()
    
    private let formView = UIStackView()
    
    private let emptyPictureButton = UIButton().then {
        $0.backgroundColor = .textFieldBackgroundColor
        $0.setTitleColor(.placeholderColor, for: .normal)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .center
    }
    
    private let pictureButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("", for: .normal)
    }

    private let pictureImageView = UIImageView()
    
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
        $0.layer.borderWidth = 1
        $0.backgroundColor = .textFieldBackgroundColor
        $0.leftViewMode = .always
    }
    
    private let categoryTitleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.font = .font(size: 10, weight: .regular)
    }
    
    private lazy var categoryDropdownField = UIMagicDropdown(
        theme: MagicDropDownConfig.category,
        items: model.categoryFieldData
    ).then {
        $0.reloadInputViews()
    }
    
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
        $0.layer.borderWidth = 1
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
    
    private let model: Model
    private let handleDidTapSaveButton: (EventFormData) -> Void
    private let handleDidTapCancelButton: () -> Void
    private let handleDidTapDeleteButton: () -> Void
    private let handleDidTapPictureButton: () -> Void
    private let handleClearError: (EventFormObligatoryField) -> Void
    
    init(
        model: Model,
        handleDidTapSaveButton: @escaping (EventFormData) -> Void,
        handleDidTapCancelButton: @escaping () -> Void,
        handleDidTapDeleteButton: @escaping () -> Void,
        handleDidTapPictureButton: @escaping () -> Void,
        handleClearError: @escaping (EventFormObligatoryField) -> Void
    ) {
        self.model = model
        self.handleDidTapSaveButton = handleDidTapSaveButton
        self.handleDidTapCancelButton = handleDidTapCancelButton
        self.handleDidTapDeleteButton = handleDidTapDeleteButton
        self.handleDidTapPictureButton = handleDidTapPictureButton
        self.handleClearError = handleClearError
        super.init()
        setUpViewHierarchy()
        setUpConstraints()
        fill(with: model)
        if let event = model.event {
            fill(with: event)
        }
        registerKeyboardListener()
        bindAction()
    }
    
    func showError(message: String?) {
        errorLabel.text = message
    }
    
    func showError(for fields: [EventFormObligatoryField]) {
        fields.forEach {
            switch $0 {
            case .price:
                priceTextField.layer.borderColor = UIColor.errorColor.cgColor
            case .title:
                eventTtitleTextField.layer.borderColor = UIColor.errorColor.cgColor
            }
        }
    }
    
    func setImage(name: String?) {
        if let name = name {
            pictureImageView.handleImage(with: name)
            pictureButton.isHidden = false
            pictureImageView.isHidden = false
            emptyPictureButton.isHidden = true
        } else {
            emptyPictureButton.isHidden = false
            pictureButton.isHidden = true
            pictureImageView.isHidden = true
        }
    }
    
    private func fill(with event: Event) {
        setImage(name: event.image)
        
        eventTtitleTextField.text = event.name
        if let startDate = event.startDate {
            startDateTextField.text = DateFormatter.yyyyMMddHHmm.string(from: startDate)
            startDateTextField.date = event.startDate
        }
        if let endDate = event.endDate {
            endDateTextField.text = DateFormatter.yyyyMMddHHmm.string(from: endDate)
            endDateTextField.date = event.endDate
        }
        priceTextField.text = "\(event.price)"
        premiumEventSwitch.isOn = event.isPremium ?? false
        categoryDropdownField.itemSelected = categoryDropdownField.items?.firstIndex(where: { $0.value as! String == event.category })
    }
    
    private func fill(with model: Model) {
        emptyPictureButton.setImage(model.emptyPicture, for: .normal)
        emptyPictureButton.setTitle(model.emptyPictureTitle, for: .normal)
        emptyPictureButton.alignVertical()
        emptyPictureButton.accessibilityIdentifier = ElementId.AddEvent.coverPhotoButton

        titleLabel.text = model.viewTitle
        eventTitleLabel.text = model.eventFieldTitle
        eventTtitleTextField.placeholder = model.eventFieldPlaceholder
        eventTtitleTextField.placeholderColor(.placeholderColor)
        eventTtitleTextField.addIconView(
            alginment: .left,
            image: model.eventFieldIcon,
            leftPadding: .defaultPadding
        )
        eventTtitleTextField.accessibilityIdentifier = ElementId.AddEvent.eventNameTextField
        
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
        startDateTextField.accessibilityIdentifier = ElementId.AddEvent.startDateTextField
        
        endDateTitleLabel.text = model.endDateFieldTitle
        endDateTextField.placeholder = model.endDateFieldPlaceholder
        endDateTextField.placeholderColor(.placeholderColor)
        endDateTextField.addIconView(
            alginment: .left,
            image: model.endDateIcon,
            leftPadding: .defaultPadding
        )
        endDateTextField.accessibilityIdentifier = ElementId.AddEvent.endDateTextField
        
        priceTitleLabel.text = model.priceFieldTitle
        priceTextField.placeholder = model.priceFieldPlaceholder
        priceTextField.placeholderColor(.placeholderColor)
        priceTextField.addIconView(
            alginment: .left,
            image: model.priceFieldIcon,
            leftPadding: .defaultPadding
        )
        priceTextField.accessibilityIdentifier = ElementId.AddEvent.eventPriceTextField
        
        premiumEventTitleLabel.text = model.premiumSwitchTitle
        
        saveButton.setTitle(model.saveButtonTitle, for: .normal)
        saveButton.accessibilityIdentifier = ElementId.AddEvent.saveButton
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
            emptyPictureButton,
            pictureImageView,
            pictureButton,
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
        setUpEmptyPictureButtonConstraints()
        setUpPictureButtonConstraints()
        setUpPictureImageViewConstraints()
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
    
    private func setUpPictureImageViewConstraints() {
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureImageView.leadingAnchor.constraint(equalTo: formView.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: formView.trailingAnchor),
            pictureImageView.topAnchor.constraint(equalTo: formView.topAnchor),
            pictureImageView.heightAnchor.constraint(equalTo: pictureImageView.widthAnchor)
        ])
    }
    
    private func setUpPictureButtonConstraints() {
        pictureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureButton.leadingAnchor.constraint(equalTo: formView.leadingAnchor),
            pictureButton.trailingAnchor.constraint(equalTo: formView.trailingAnchor),
            pictureButton.topAnchor.constraint(equalTo: formView.topAnchor),
            pictureButton.heightAnchor.constraint(equalTo: pictureButton.widthAnchor)
        ])
    }
    
    private func setUpEmptyPictureButtonConstraints() {
        emptyPictureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyPictureButton.leadingAnchor.constraint(equalTo: formView.leadingAnchor),
            emptyPictureButton.trailingAnchor.constraint(equalTo: formView.trailingAnchor),
            emptyPictureButton.topAnchor.constraint(equalTo: formView.topAnchor),
            emptyPictureButton.heightAnchor.constraint(equalTo: emptyPictureButton.widthAnchor)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: .defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -.defaultPadding),
            titleLabel.topAnchor.constraint(equalTo: emptyPictureButton.bottomAnchor, constant: Constants.spacing)
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
            categoryDropdownField.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: Constants.smallSpacing)
        ])
        categoryDropdownField.accessibilityIdentifier = ElementId.AddEvent.eventCategoryDropdown
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
        premiumEventSwitch.accessibilityIdentifier = ElementId.AddEvent.premiumEventSwitch
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
        eventTtitleTextField.addTarget(self, action: #selector(valueChanged(_ :)), for: .editingChanged)
        priceTextField.addTarget(self, action: #selector(valueChanged(_ :)), for: .editingChanged)
        eventTtitleTextField.delegate = self
        priceTextField.delegate = self
        categoryDropdownField.dropDownDelegate = self
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        emptyPictureButton.addTarget(self, action: #selector(didTapPictureButton), for: .touchUpInside)
        pictureButton.addTarget(self, action: #selector(didTapPictureButton), for: .touchUpInside)
    }
    
    @objc private func didTapSaveButton() {
        handleDidTapSaveButton(EventFormData(
            name: eventTtitleTextField.text,
            category: categoryDropdownField.itemSelected,
            price: priceTextField.text,
            dateFrom: startDateTextField.date,
            dateTo: endDateTextField.date,
            isPremium: premiumEventSwitch.isOn
        ))
    }
    
    @objc private func didTapCancelButton() {
        handleDidTapCancelButton()
    }
    
    @objc private func didTapDeleteButton() {
        handleDidTapDeleteButton()
    }
    
    @objc private func didTapPictureButton() {
        endEditing(true)
        handleDidTapPictureButton()
    }
    
    private func registerKeyboardListener(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardDidShow(notification:)),
            name: UIResponder.keyboardDidShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardDidHide(notification:)),
            name: UIResponder.keyboardDidHideNotification, object: nil
        )
    }
    
    //MARK: Methods to manage keybaord
    @objc func keyboardDidShow(notification: NSNotification) {
        var info = notification.userInfo
        let keyBoardSize = info![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func valueChanged(_ textField: UITextField) {
        clearError(for: textField)
    }
    
    private func clearError(for textField: UITextField) {
        if textField == priceTextField {
            handleClearError(.price)
        }
        if textField == eventTtitleTextField {
            handleClearError(.title)
        }
        textField.layer.borderColor = UIColor.clear.cgColor
    }
}

extension EventFormView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearError(for: textField)
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
