import UIKit

final class EventListViewController: UIViewController {
    private let viewModel: EventListViewModel
    private lazy var mainView = EventListView(
        model: viewModel.loadModel(),
        handleDidTapEventsButton: {},
        handleDidTapAddButton: {}
    )
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
}
