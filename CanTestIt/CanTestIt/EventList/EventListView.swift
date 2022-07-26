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
    
    private let tableView = UITableView().then {
        $0.register(EventListTableViewCell.self)
        $0.register(EmptyEventListTableViewCell.self)
        $0.backgroundColor = .backgroundColor
    }
    
    private let footerView = UIView(frame: .zero).then {
        $0.backgroundColor = .black
    }
    
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
    
    private let bottomSafeAreaCoverView = UIView(frame: .zero).then {
        $0.backgroundColor = .black
    }
    
    private lazy var dataSource = EventListTableViewDataSource(tableView)
    private let handleDidTapEventsButton: () -> Void
    private let handleDidTapAddButton: () -> Void
    private let handleDidTapEvent: (Int) -> Void
    
    init(
        model: Model,
        handleDidTapEvent: @escaping (Int) -> Void,
        handleDidTapEventsButton: @escaping () -> Void,
        handleDidTapAddButton: @escaping () -> Void
    ) {
        self.handleDidTapEvent = handleDidTapEvent
        self.handleDidTapAddButton = handleDidTapAddButton
        self.handleDidTapEventsButton = handleDidTapEventsButton
        super.init()
        fill(with: model)
        setUpViewHierarchy()
        setUpConstraints()
        tableView.delegate = self
    }
    
    func reloadTable(with data: [EventListData]) {
        dataSource.reload(with: data)
     }
    
    private func fill(with model: Model) {
        welcomeLabel.text = model.welcomeText
        titleLabel.text = model.title
        eventsButton.setTitle(model.eventsButtonTitle, for: .normal)
        searchField.placeholder = model.searchFieldPlaceholder
        searchField.placeholderColor(.placeholderColor)
    }
    
    private func setUpViewHierarchy() {
        addSubviews([
            containerView,
            bottomSafeAreaCoverView
        ])
        containerView.addSubviews([
            welcomeLabel,
            titleLabel,
            searchField,
            tableView,
            footerView
        ])
        
        footerView.addSubviews([
            eventsButton,
            addButton
        ])
    }
    
    private func setUpConstraints() {
        setUpWelcomeLabelConstraints()
        setUpTitleLabelConstraints()
        setUpSearchFieldConstraints()
        setUpTableViewConstraints()
        setUpFooterViewConstraints()
        setUpAddButtonConstraints()
        setUpEventsButtonConstraints()
        setUpBottomSafeAreaCoverViewConstraints()
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
    
    private func setUpFooterViewConstraints() {
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            footerView.topAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
    
    private func setUpAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: Constants.spacing),
            addButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -Constants.spacing),
            addButton.heightAnchor.constraint(equalToConstant: Constants.addButtonSize),
            addButton.widthAnchor.constraint(equalToConstant: Constants.addButtonSize)
        ])
    }
    
    private func setUpEventsButtonConstraints() {
        eventsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventsButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: Constants.padding),
            eventsButton.heightAnchor.constraint(equalToConstant: Constants.eventsButtonSize),
            eventsButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor)
        ])
    }
    
    private func setUpBottomSafeAreaCoverViewConstraints() {
        bottomSafeAreaCoverView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomSafeAreaCoverView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSafeAreaCoverView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSafeAreaCoverView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSafeAreaCoverView.topAnchor.constraint(equalTo: footerView.bottomAnchor)
        ])
    }
    
    @objc private func didTapEventsButton() {
        handleDidTapEventsButton()
    }
    
    @objc private func didTapAddButton() {
        handleDidTapAddButton()
    }
}

extension EventListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleDidTapEvent(indexPath.row)
    }
}
