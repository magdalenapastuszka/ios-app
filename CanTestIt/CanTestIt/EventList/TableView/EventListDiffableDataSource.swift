import Foundation
import UIKit

enum EventListSection: Hashable {
    case main
    case empty
}

enum EventLisSectionItem: Hashable {
    case main(EventListTableViewCell.Model)
    case empty(EmptyEventListTableViewCell.Model)
}

struct EventListData {
    var key: EventListSection
    var values: [EventLisSectionItem]
}

final class EventListTableViewDataSource: UITableViewDiffableDataSource<EventListSection, EventLisSectionItem> {
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main(let model):
                let cell = tableView.reuse(EventListTableViewCell.self, indexPath)
                cell.selectionStyle = .none
                cell.configure(with: model)
                return cell
            case .empty(_):
                let cell = tableView.reuse(EmptyEventListTableViewCell.self, indexPath)
                cell.selectionStyle = .none
                return cell
            }
        }
    }

    func reload(with data: [EventListData], animated: Bool = false) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        for item in data {
            snapshot.appendSections([item.key])
            snapshot.appendItems(item.values, toSection: item.key)
        }
        apply(snapshot, animatingDifferences: animated)
    }
}
