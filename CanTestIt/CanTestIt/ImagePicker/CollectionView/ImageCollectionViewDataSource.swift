import Foundation
import UIKit

enum ImageCollectionSection: Hashable {
    case main
}

struct ImageCollectionSectionItem: Hashable {
    let image: UIImage
}

final class ImageCollectionViewDataSource: UICollectionViewDiffableDataSource<ImageCollectionSection, ImageCollectionSectionItem> {
    
    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.reuse(ImageCollectionViewCell.self, indexPath)
            cell.configure(with: item.image)
            return cell
        }
    }

    func reload(with items: [ImageCollectionSectionItem], animated: Bool = true) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
    
        apply(snapshot, animatingDifferences: animated)
    }
}
