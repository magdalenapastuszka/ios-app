import UIKit

final class ImagePickerView: BaseView {
    struct Model {
        let buttonTitle: String
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout
    )
    
    private let chooseButton = UIButton().then {
        $0.backgroundColor = .primaryColor
        $0.layer.cornerRadius = .buttonCornerRadius
        $0.setTitleColor(.buttonTitleColor, for: .normal)
    }
    
    private let pageControl = UIPageControl(frame: .zero)
    
    private let layout = ImagePickerCollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 250, height: 250)
    }
    private lazy var dataSource = ImageCollectionViewDataSource(collectionView)
    
    init(model: Model) {
        super.init()
        fill(with: model)
        setUpViewHierarchy()
        setUpConstraints()
    }
    
    func reloadCollectionView(with data: [ImageCollectionData]) {
        dataSource.reload(with: data)
     }
    
    private func fill(with model: Model) {
        chooseButton.setTitle(model.buttonTitle, for: .normal)
    }
    
    private func setUpViewHierarchy() {
        containerView.addSubviews([
            collectionView,
            chooseButton,
            pageControl
        ])
    }
    
    private func setUpConstraints() {
        setUpCollectionViewConstraints()
        setUpChooseButtonConstraints()
        setUpPageControlConstraints()
    }
    
    private func setUpCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
    
    private func setUpChooseButtonConstraints() {
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            chooseButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            chooseButton.heightAnchor.constraint(equalToConstant: .buttonHeight)
        ])
    }
    
    private func setUpPageControlConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
        ])
    }
}
