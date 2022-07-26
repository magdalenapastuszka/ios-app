import UIKit

final class MenuListTableViewCell: UITableViewCell {
    struct Model: Hashable {
        let id = UUID()
        let image: UIImage
        let title: String
        let textColor: UIColor
        let action: (() -> Void)?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
        
        static func == (lhs: Model, rhs: Model) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    private enum Constants {
        static let smallPadding: CGFloat = 10
        static let padding: CGFloat = 30
        static let iconSize: CGFloat = 40
        static let cornerRadius: CGFloat = 8
    }
    
    private let pictureView = UIButton().then {
        $0.backgroundColor = .secondaryBackgroundColor
        $0.layer.cornerRadius = Constants.cornerRadius
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .font(.callout)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViewHierarchy()
        setUpConstraints()
        contentView.backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        pictureView.setImage(model.image, for: .normal)
        titleLabel.text = model.title
        titleLabel.textColor = model.textColor
    }
    
    private func setUpViewHierarchy() {
        contentView.addSubviews([
            pictureView,
            titleLabel
        ])
    }
    
    private func setUpConstraints() {
        setUpPictureViewConstraints()
        setUpTitleLabelConstraints()
    }
    
    private func setUpPictureViewConstraints() {
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            pictureView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            pictureView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.smallPadding),
            pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.smallPadding)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: .defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}
