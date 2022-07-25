import UIKit

final class EventListViewController: BaseViewController {
    private let viewModel: EventListViewModel
    private lazy var mainView = EventListView(
        model: viewModel.loadModel(),
        handleDidTapEventsButton: {},
        handleDidTapAddButton: {}
    )
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }

    
    override func loadView() {
        view = mainView
    }
}
