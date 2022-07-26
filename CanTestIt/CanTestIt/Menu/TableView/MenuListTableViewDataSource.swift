import Foundation
import UIKit

enum MenuListSection: Hashable {
    case main
}

enum MenuLisSectionItem: Hashable {
    case main(MenuListTableViewCell.Model)
}

struct MenuListData {
    var key: MenuListSection
    var values: [MenuLisSectionItem]
}

final class MenuListTableViewDataSource: UITableViewDiffableDataSource<MenuListSection, MenuLisSectionItem> {
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main(let model):
                let cell = tableView.reuse(MenuListTableViewCell.self, indexPath)
                cell.selectionStyle = .none
                cell.configure(with: model)
                return cell
            }
        }
    }

    func reload(with data: [MenuListData], animated: Bool = true) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        for item in data {
            snapshot.appendSections([item.key])
            snapshot.appendItems(item.values, toSection: item.key)
        }
        apply(snapshot, animatingDifferences: animated)
    }
}
