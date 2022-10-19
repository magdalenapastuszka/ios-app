import UIKit
import Combine
import NotificationCenter

final class EventFormViewController: BaseViewController {
    private lazy var mainView = EventFormView(
        model: viewModel.loadModel(),
        handleDidTapSaveButton: viewModel.didTapSaveButton,
        handleDidTapCancelButton: viewModel.didTapCancelButton,
        handleDidTapDeleteButton: viewModel.didTapDeleteButton,
        handleDidTapPictureButton: viewModel.didTapPictureButton,
        handleClearError: viewModel.clearError(from:)
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
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.mainView.showError(message: error)
            }
            .store(in: &cancellables)
        
        viewModel.$obligatoryFieldsWithError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fieldsWithError in
                self?.mainView.showError(for: fieldsWithError)
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.showHud() : self?.dismissHud()
            }
            .store(in: &cancellables)
        
        viewModel.$selectedImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                self?.mainView.setImage(name: name)
            }
            .store(in: &cancellables)
        
        viewModel.$notificationMessage
            .receive(on: DispatchQueue.main)
            .sink { message in
                guard let message = message else { return }
                
                NotificationCenter.shared.showMessage(with: message)
            }
            .store(in: &cancellables)
    }
}
