import UIKit

final class DateTextField: TextFieldWithPadding {
    private let toolbar = UIToolbar().then {
        let doneButton = UIBarButtonItem(
            title: "date-picker-view.done-button-title".localized,
            style: .plain,
            target: self,
            action: #selector(didTapDone)
        )
        $0.setItems([doneButton], animated: true)
        $0.sizeToFit()
        $0.tintColor = .textColor
        $0.barTintColor = .textFieldBackgroundColor
        $0.isTranslucent = false
    }
    
    private let containerView = UIView(frame: CGRect(
        x: 0,
        y: 0,
        width: UIScreen.main.bounds.width,
        height: 400
    )).then {
        $0.backgroundColor = .textFieldBackgroundColor
    }
    
    private let datePicker = UIDatePicker().then {
        $0.date = Date()
        $0.locale = .current
        $0.preferredDatePickerStyle = .inline
        $0.backgroundColor = .white
        $0.sizeToFit()
        $0.overrideUserInterfaceStyle = .dark
        $0.backgroundColor = .textFieldBackgroundColor
        $0.tintColor = .primaryColor
    }
    
    override init() {
        super.init()
        setupViewHierarchy()
        setUpDatePickerConstraints()
        self.inputAccessoryView = toolbar
        self.inputView = containerView
    }
    
    private func setupViewHierarchy() {
        containerView.addSubview(datePicker)
    }
    
    private func setUpDatePickerConstraints() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    @objc private func didTapDone() {
        self.text = DateFormatter.yyyyMMddHHmm.string(from: datePicker.date)
        self.resignFirstResponder()
    }
}
