import UIKit

final class ImagePickerView: BaseView {
    struct Model {
        let buttonTitle: String
    }
    
    private enum Constants {
        static let bottomPadding: CGFloat = 70
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout
    ).then {
        $0.register(ImageCollectionViewCell.self)
        $0.backgroundColor = .backgroundColor
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    private let chooseButton = UIButton().then {
        $0.backgroundColor = .primaryColor
        $0.layer.cornerRadius = .buttonCornerRadius
        $0.setTitleColor(.buttonTitleColor, for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: .defaultPadding, bottom: 0, right: .defaultPadding)
        $0.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
    }
    
    private let pageControl = UIPageControl(frame: .zero).then {
        $0.tintColor = .white
    }
    
    private let layout = ImagePickerCollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 250, height: 250)
        $0.scrollDirection = .horizontal
    }
    private lazy var dataSource = ImageCollectionViewDataSource(collectionView)
    
    private let handleDidTapChooseButton: (Int?) -> Void
    
    init(
        model: Model,
        handleDidTapChooseButton: @escaping (Int?) -> Void
    ) {
        self.handleDidTapChooseButton = handleDidTapChooseButton
        super.init()
        fill(with: model)
        setUpViewHierarchy()
        setUpConstraints()
        collectionView.delegate = self
    }
    
    func reloadCollectionView(with data: [ImageCollectionData]) {
        dataSource.reload(with: data)
        pageControl.numberOfPages = data[0].values.count
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
            chooseButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: .defaultPadding),
            chooseButton.heightAnchor.constraint(equalToConstant: .buttonHeight)
        ])
    }
    
    private func setUpPageControlConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.bottomPadding),
            pageControl.topAnchor.constraint(equalTo: chooseButton.bottomAnchor, constant: Constants.bottomPadding)
        ])
    }
    
    @objc private func didTapChooseButton() {
        handleDidTapChooseButton(layout.currentCenteredPage)
    }
}

extension ImagePickerView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = layout.currentCenteredPage ?? 0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        pageControl.currentPage = layout.currentCenteredPage ?? 0
    }
}
