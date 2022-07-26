import UIKit

final class MenuView: BaseView {
    struct Model {
        let name: String
        let email: String
    }
    
    private enum Constants {
        static let padding: CGFloat = 30
        static let tableViewTopPadding: CGFloat = 60
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .font(size: 20, weight: .semibold)
        $0.textColor = .textColor
    }
    
    private let emailLabel = UILabel().then {
        $0.font = .font(.callout)
        $0.textColor = .textColor
    }
    
    private let tableView = UITableView().then {
        $0.register(MenuListTableViewCell.self)
        $0.backgroundColor = .backgroundColor
        $0.separatorStyle = .none
    }
    
    private lazy var dataSource = MenuListTableViewDataSource(tableView)
    
    init(model: Model) {
        super.init()
        fill(with: model)
        setUpViewHierarchy()
        setUpConstraints()
        tableView.delegate = self
    }
    
    func reloadTable(with data: [MenuListData]) {
        dataSource.reload(with: data)
     }
    
    private func fill(with model: Model) {
        nameLabel.text = model.name
        emailLabel.text = model.email
    }
    
    private func setUpViewHierarchy() {
        containerView.addSubviews([
            nameLabel,
            emailLabel,
            tableView
        ])
    }
    
    private func setUpConstraints() {
        setUpNameLabelConstraints()
        setUpEmailLabelConstraints()
        setUpTableViewConstraints()
    }
    
    private func setUpNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.padding),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding)
        ])
    }
    
    private func setUpEmailLabelConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding),
            emailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding)
        ])
    }
    
    private func setUpTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Constants.tableViewTopPadding),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}

extension MenuView: UITableViewDelegate {
    
}
