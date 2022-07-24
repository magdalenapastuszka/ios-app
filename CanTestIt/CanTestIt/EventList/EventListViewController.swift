import UIKit

final class EventListViewController: UIViewController {
    private let viewModel: EventListViewModel
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
