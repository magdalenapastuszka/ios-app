import UIKit
import Combine

final class EventFormViewController: BaseViewController {
    private lazy var mainView = EventFormView(
        model: viewModel.loadModel(),
        handleDidTapSaveButton: viewModel.didTapSaveButton,
        handleDidTapCancelButton: viewModel.didTapCancelButton,
        handleDidTapDeleteButton: viewModel.didTapDeleteButton,
        handleDidTapImageView: viewModel.didTapImageView
    )
    private let viewModel: EventFormViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: EventFormViewModel) {
        self.viewModel = viewModel
        super.init()
        bindAction()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func bindAction() {
        viewModel.$error
            .sink { [weak self] error in
                self?.mainView.showError(message: error)
            }
            .store(in: &cancellables)
    }
}
