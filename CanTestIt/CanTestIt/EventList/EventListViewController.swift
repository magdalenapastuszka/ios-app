import UIKit
import Combine

final class EventListViewController: BaseViewController {
    private let viewModel: EventListViewModel
    private lazy var mainView = EventListView(
        model: viewModel.loadModel(),
        handleSearchFieldDidChange: viewModel.didChangeSearchField,
        handleDidTapEvent: viewModel.didTapEvent,
        handleDidTapEventsButton: {},
        handleDidTapAddButton: viewModel.didTapAddButton
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadEvents()
    }
    
    private func bindAction() {
        viewModel.$tableViewData
            .sink { [weak self] data in
                self?.mainView.reloadTable(with: data)
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .sink{ [weak self] newValue in
                newValue ? self?.showHud() : self?.dismissHud()
            }
            .store(in: &cancellables)
    }
}
