import UIKit

final class EventListView: BaseView {
    struct Model {
        let welcomeText: String
        let title: String
        let searchFieldPlaceholder: String
        let eventsButtonTitle: String
    }
    
    private enum Constants {
        static let eventsButtonSize: CGFloat = 30
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 24
        static let spacing: CGFloat = 12
        static let tableViewTopPadding: CGFloat = 30
        static let addButtonSize: CGFloat = 42
    }
        
    private let welcomeLabel = UILabel().then {
        $0.font = .font(.callout)
        $0.textColor = .primaryColor
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .font(.title1)
        $0.textColor = .textColor
    }
    
    private let searchField = TextFieldWithPadding().then {
        $0.backgroundColor = .secondaryBackgroundColor
        $0.textColor = .textColor
        $0.layer.cornerRadius = Constants.cornerRadius
        let leftView = UIButton()
        leftView.setImage(.loupe, for: .normal)
        leftView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -.defaultPadding)
        $0.leftView = leftView
        $0.leftViewMode = .always
    }
    
    private let tableView = UITableView()
    
    private let eventsButton = UIButton().then {
        $0.setImage(.house, for: .normal)
        $0.layer.cornerRadius = Constants.eventsButtonSize
        $0.setTitleColor(.textColor, for: .normal)
        $0.backgroundColor = .alternativeBsackgroundColor
        $0.addTarget(self, action: #selector(didTapEventsButton), for: .touchUpInside)
    }
    
    private let addButton = UIButton().then {
        $0.setImage(.plus, for: .normal)
        $0.backgroundColor = .alternativeBsackgroundColor
        $0.layer.cornerRadius = Constants.cornerRadius
        $0.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    private let handleDidTapEventsButton: () -> Void
    private let handleDidTapAddButton: () -> Void
    
    init(
        model: Model,
        handleDidTapEventsButton: @escaping () -> Void,
        handleDidTapAddButton: @escaping () -> Void
    ) {
        self.handleDidTapAddButton = handleDidTapAddButton
        self.handleDidTapEventsButton = handleDidTapEventsButton
        super.init()
        fill(with: model)
        setUpViewHierarchy()
        setUpConstraints()
    }
    
    private func fill(with model: Model) {
        welcomeLabel.text = model.welcomeText
        titleLabel.text = model.title
        eventsButton.setTitle(model.eventsButtonTitle, for: .normal)
        searchField.placeholder = model.searchFieldPlaceholder
        searchField.placeholderColor(.placeholderColor)
    }
    
    private func setUpViewHierarchy() {
        addSubview(containerView)
        containerView.addSubviews([
            welcomeLabel,
            titleLabel,
            searchField,
            tableView,
            eventsButton,
            addButton
        ])
    }
    
    private func setUpConstraints() {
        setUpWelcomeLabelConstraints()
        setUpTitleLabelConstraints()
        setUpSearchFieldConstraints()
        setUpTableViewConstraints()
        setUpAddButtonConstraints()
        setUpEventsButtonConstraints()
    }
    
    private func setUpWelcomeLabelConstraints() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding),
            welcomeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding),
            welcomeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.padding)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding),
            titleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor)
        ])
    }
    
    private func setUpSearchFieldConstraints() {
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding),
            searchField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding),
            searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.spacing),
            searchField.heightAnchor.constraint(equalToConstant: .buttonHeight)
        ])
    }
    
    private func setUpTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding),
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: Constants.tableViewTopPadding)
        ])
    }
    
    private func setUpAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constants.spacing),
            addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.spacing),
            addButton.heightAnchor.constraint(equalToConstant: Constants.addButtonSize),
            addButton.widthAnchor.constraint(equalToConstant: Constants.addButtonSize)
        ])
    }
    
    private func setUpEventsButtonConstraints() {
        eventsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding),
            eventsButton.heightAnchor.constraint(equalToConstant: Constants.eventsButtonSize),
            eventsButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor)
        ])
    }
    
    @objc private func didTapEventsButton() {
        handleDidTapEventsButton()
    }
    
    @objc private func didTapAddButton() {
        handleDidTapAddButton()
    }
}
