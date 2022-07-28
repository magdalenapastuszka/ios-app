import Foundation
import UIKit

enum ImageCollectionSection: Hashable {
    case main
}

enum ImageCollectionSectionItem: Hashable {
    case main(UIImage)
}

struct ImageCollectionData {
    var key: ImageCollectionSection
    var values: [ImageCollectionSectionItem]
}

final class ImageCollectionViewDataSource: UICollectionViewDiffableDataSource<ImageCollectionSection, ImageCollectionSectionItem> {
    
    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main(let image):
                let cell = collectionView.reuse(ImageCollectionViewCell.self, indexPath)
                cell.configure(with: image)
                return cell
            }
        }
    }

    func reload(with data: [ImageCollectionData], animated: Bool = true) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        for item in data {
            snapshot.appendSections([item.key])
            snapshot.appendItems(item.values, toSection: item.key)
        }
        apply(snapshot, animatingDifferences: animated)
    }
}
