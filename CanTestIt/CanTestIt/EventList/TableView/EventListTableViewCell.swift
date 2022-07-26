import UIKit

final class EventListTableViewCell: UITableViewCell {
    struct Model: Hashable {
        let id = UUID()
        let title: String
        let image: UIImage
        let priceTitle: String
        let price: String
        let category: String
        let startDateTitle: String
        let startDate: String
        let startHour: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
        
        static func == (lhs: Model, rhs: Model) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    private enum Constants {
        static let padding: CGFloat = 20
        static let spacing: CGFloat = 8
        static let iconSize: CGFloat = 19
        static let categoryLabelHeight: CGFloat = 20
    }
    
    private let pictureView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let infoContainer = UIView().then {
        $0.backgroundColor = .secondaryBackgroundColor
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .font(.title3)
        $0.textColor = .textColor
    }
    
    private let startDateContainerView = UIView()
    
    private let startDateTitleLabel = UILabel().then {
        $0.textColor = .primaryColor
        $0.font = .font(size: 6, weight: .regular)
    }
    
    private let startDateImageView = UIImageView(image: .calendar)
    
    private let startDateLabel = UILabel().then {
        $0.font = .font(.caption2)
        $0.textColor = .textColor
    }
    
    private let startDateHourLabel = UILabel().then {
        $0.font = .font(size: 8, weight: .regular)
        $0.textColor = .textColor
    }
    
    private let categoryLabel = UILabel().then {
        $0.textColor = .primaryColor
        $0.font = .font(size: 8, weight: .regular)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .backgroundColor
    }
    
    private let priceContainerView = UIView()
    
    private let priceTitleLabel = UILabel().then {
        $0.textColor = .primaryColor
        $0.font = .font(size: 6, weight: .regular)
    }
    
    private let priceImageView = UIImageView(image: .wallet)
    
    private let priceLabel = UILabel().then {
        $0.font = .font(.caption2)
        $0.textColor = .textColor
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
    
    func configure(with model: Model) {
        pictureView.image = model.image
        titleLabel.text = model.title
        priceTitleLabel.text = model.priceTitle
        priceLabel.text = model.price
        startDateTitleLabel.text = model.startDateTitle
        startDateLabel.text = model.startDate
        startDateHourLabel.text = model.startHour
    }
    
    private func setUpViewHierarchy() {
        contentView.addSubviews([
            pictureView,
            infoContainer
        ])
        
        infoContainer.addSubviews([
            titleLabel,
            startDateContainerView,
            categoryLabel,
            priceContainerView
        ])
        
        startDateContainerView.addSubviews([
            startDateTitleLabel,
            startDateImageView,
            startDateLabel,
            startDateHourLabel,
        ])
        
        priceContainerView.addSubviews([
            priceTitleLabel,
            priceImageView,
            priceLabel
        ])
    }
    
    private func setUpConstraints() {
        setUpPictureViewConstraints()
        setUpInfoContainerConstraints()
        setUpTitleLabelConstraints()
        setUpStartDateContainerViewConstraints()
        setUpStartDateImageViewConstraints()
        setUpStartDateTitleLabelConstraints()
        setUpStartDateLabelConstraints()
        setUpstartDateHourLabelConstraints()
        setUpCategoryLabelConstraints()
        setUpPriceContainerViewConstraints()
        setUpPriceTitleLabelConstraints()
        setUpPriceImageViewConstraints()
        setUpPriceLabelConstraints()
    }
    
    private func setUpPictureViewConstraints() {
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    private func setUpInfoContainerConstraints() {
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: Constants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -Constants.padding),
            titleLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: Constants.spacing)
        ])
    }
    
    private func setUpStartDateContainerViewConstraints() {
        startDateContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateContainerView.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: Constants.padding),
            startDateContainerView.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: Constants.spacing),
            startDateContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.spacing)
        ])
    }
    
    private func setUpStartDateImageViewConstraints() {
        startDateImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateImageView.leadingAnchor.constraint(equalTo: startDateContainerView.leadingAnchor),
            startDateImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            startDateImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            startDateImageView.centerYAnchor.constraint(equalTo: startDateContainerView.centerYAnchor)
        ])
    }
    
    private func setUpStartDateTitleLabelConstraints() {
        startDateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateTitleLabel.topAnchor.constraint(equalTo: startDateContainerView.topAnchor),
            startDateTitleLabel.leadingAnchor.constraint(equalTo: startDateImageView.trailingAnchor),
            startDateTitleLabel.trailingAnchor.constraint(equalTo: startDateContainerView.trailingAnchor)
        ])
    }
    
    private func setUpStartDateLabelConstraints(){
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateLabel.topAnchor.constraint(equalTo: startDateTitleLabel.bottomAnchor),
            startDateLabel.leadingAnchor.constraint(equalTo: startDateImageView.trailingAnchor),
            startDateLabel.trailingAnchor.constraint(equalTo: startDateContainerView.trailingAnchor)
        ])
    }
    
    private func setUpstartDateHourLabelConstraints() {
        startDateHourLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateHourLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor),
            startDateHourLabel.leadingAnchor.constraint(equalTo: startDateImageView.trailingAnchor),
            startDateHourLabel.trailingAnchor.constraint(equalTo: startDateContainerView.trailingAnchor),
            startDateHourLabel.bottomAnchor.constraint(equalTo: startDateContainerView.bottomAnchor)
        ])
    }
    
    private func setUpCategoryLabelConstraints() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: startDateContainerView.centerYAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: startDateContainerView.trailingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: Constants.categoryLabelHeight)
        ])
    }
    
    private func setUpPriceContainerViewConstraints() {
        priceContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceContainerView.topAnchor.constraint(equalTo: startDateContainerView.topAnchor),
            priceContainerView.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
            priceContainerView.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -Constants.padding),
            priceContainerView.bottomAnchor.constraint(equalTo: startDateContainerView.bottomAnchor)
        ])
    }
    
    private func setUpPriceTitleLabelConstraints() {
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceTitleLabel.topAnchor.constraint(equalTo: priceContainerView.topAnchor),
            priceTitleLabel.leadingAnchor.constraint(equalTo: priceImageView.trailingAnchor),
            priceTitleLabel.trailingAnchor.constraint(equalTo: priceContainerView.trailingAnchor),
        ])
    }
    
    private func setUpPriceImageViewConstraints() {
        priceImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceImageView.leadingAnchor.constraint(equalTo: priceContainerView.leadingAnchor),
            priceImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            priceImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            priceImageView.centerYAnchor.constraint(equalTo: priceContainerView.centerYAnchor)
        ])
    }
    
    private func setUpPriceLabelConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: priceImageView.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: priceContainerView.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor)
        ])
    }
}
