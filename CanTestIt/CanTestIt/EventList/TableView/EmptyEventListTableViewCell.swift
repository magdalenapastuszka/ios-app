import UIKit

final class EmptyEventListTableViewCell: UITableViewCell {
    struct Model: Hashable {
        let id = UUID()
        let title: String = "event-list.empty-cell.title".localized
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
        
        static func == (lhs: Model, rhs: Model) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    private enum Constants {
        static let imageSize: CGSize = CGSize(width: 250, height: 230)
        static let topPadding: CGFloat = 70
        static let titleTopPadding: CGFloat = 20
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .textColor
        $0.text = "event-list.empty-cell.title".localized
        $0.font = .font(.title1)
        $0.textAlignment = .center
    }
    
    private let pictureView = UIImageView(image: .noResult).then {
        $0.contentMode = .scaleAspectFit
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViewHierarchy()
        setUpConstraints()
        backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topPadding),
            pictureView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pictureView.widthAnchor.constraint(equalToConstant: Constants.imageSize.width),
            pictureView.heightAnchor.constraint(equalToConstant: Constants.imageSize.height)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: Constants.titleTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.defaultPadding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
