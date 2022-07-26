import UIKit
import Combine

final class EventListViewController: BaseViewController {
    private let viewModel: EventListViewModel
    private lazy var mainView = EventListView(
        model: viewModel.loadModel(),
        handleDidTapEvent: viewModel.didTapEvent,
        handleDidTapEventsButton: {},
        handleDidTapAddButton: {}
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        super.init()
        bindAction()
    }

    
    override func loadView() {
        view = mainView
    }
    
    private func bindAction() {
        viewModel.$tableViewData
            .sink { [weak self] data in
                self?.mainView.reloadTable(with: data)
            }
            .store(in: &cancellables)
    }
}
