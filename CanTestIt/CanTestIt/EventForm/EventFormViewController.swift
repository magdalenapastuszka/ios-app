import UIKit
import Combine

final class EventFormViewController: BaseViewController {
    private lazy var mainView = EventFormView(
        model: viewModel.loadModel(),
        handleDidTapSaveButton: viewModel.didTapSaveButton,
        handleDidTapCancelButton: viewModel.didTapCancelButton,
        handleDidTapDeleteButton: viewModel.didTapDeleteButton,
        handleDidTapPictureButton: viewModel.didTapPictureButton
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
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                self?.mainView.showError(message: error)
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.showHud() : self?.dismissHud()
            }
            .store(in: &cancellables)
        
        viewModel.$selectedImage
            .receive(on: RunLoop.main)
            .sink { [weak self] name in
                self?.mainView.setImage(name: name)
            }
            .store(in: &cancellables)
    }
}
