import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    private let pictureView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(pictureView)
        setUpPictureViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        pictureView.image = image
    }
    
    private func setUpPictureViewConstraints() {
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
