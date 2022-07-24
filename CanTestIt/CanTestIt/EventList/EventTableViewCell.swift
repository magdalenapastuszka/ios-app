import UIKit

final class EventTableViewCell: UITableViewCell {
    private enum Constants {
        static let padding: CGFloat = 20
        static let spacing: CGFloat = 8
        static let iconSize: CGFloat = 19
    }
    
    private let pictureView = UIImageView()
    
    private let infoContainer = UIView()
    
    private let titleLabel = UILabel()
    
    private let startDateContainerView = UIView()
    
    private let startDateTitleLabel = UILabel()
    
    private let startDateImageView = UIImageView()
    
    private let startDateLabel = UILabel()
    
    private let startDateHourLabel = UILabel()
    
    private let categoryLabel = UILabel()
    
    private let priceContainerView = UIView()
    
    private let priceTitleLabel = UILabel()
    
    private let priceImageView = UIImageView()
    
    private let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViewHierarchy()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
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
            categoryLabel.leadingAnchor.constraint(equalTo: startDateContainerView.trailingAnchor)
        ])
    }
    
    private func setUpPriceContainerViewConstraints() {
        priceContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceContainerView.topAnchor.constraint(equalTo: startDateContainerView.topAnchor),
            priceContainerView.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
            priceContainerView.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -Constants.padding)
        ])
    }
    
    private func setUpPriceTitleLabelConstraints() {
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
        ])
    }
}
